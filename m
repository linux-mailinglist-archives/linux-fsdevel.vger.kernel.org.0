Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4CFC894
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKNONb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 09:13:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40268 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKNONa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:13:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVFs8-0004Zd-4C; Thu, 14 Nov 2019 14:13:20 +0000
Date:   Thu, 14 Nov 2019 14:13:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2] fs: add new O_MNT flag for opening mount root from
 mountpoint fd
Message-ID: <20191114141320.GI26530@ZenIV.linux.org.uk>
References: <20191114090454.27903-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114090454.27903-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:04:54PM +0300, Pavel Tikhomirov wrote:

> More precisely the algorithm is:
> a) openat mpfd to a new mountpoint through parent mount's root -
> p_rootfd (which we already have) or mountpoint fd under a sibling mount
> - s_mpfd if our mountpoint is already overmounted.
> b) create a new mount on mpfd via /proc/<pid>/fd/<N> interface
> c) openat it's rootfd via O_MNT from mpfd
> 
> If we have mpfd and rootfd for each mount through /proc/<pid>/fd/<N>
> interface we will be able to bindmount any part of each of already
> created mounts to restore other mounts  and we will be able to configure
> mounts, e.g. change sharing or other options even if mounts are
> invisible from fs-root.

Everything else aside (and I'm not thrilled about the idea in general),
you are not handling the situation when that overmount is, in turn,
overmounted.  Or when there's an automount set on top of it, etc.
