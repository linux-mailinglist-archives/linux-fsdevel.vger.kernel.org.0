Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F4402F7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbhIGUQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:16:50 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:48290 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbhIGUQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:16:50 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNhTF-00278w-GQ; Tue, 07 Sep 2021 20:13:29 +0000
Date:   Tue, 7 Sep 2021 20:13:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] namei: Standardize callers of filename_create()
Message-ID: <YTfH6RW+3+5kVD+y@zeniv-ca.linux.org.uk>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
 <20210901175144.121048-4-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901175144.121048-4-stephen.s.brennan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 01, 2021 at 10:51:43AM -0700, Stephen Brennan wrote:
>  inline struct dentry *user_path_create(int dfd, const char __user *pathname,
>  				struct path *path, unsigned int lookup_flags)
>  {
> -	return filename_create(dfd, getname(pathname), path, lookup_flags);
> +	struct filename *filename;
> +	struct dentry *dentry;
> +
> +	filename = getname(pathname);
> +	dentry = filename_create(dfd, getname(pathname), path, lookup_flags);
> +	putname(filename);
> +	return dentry;

Leaks, obviously...
