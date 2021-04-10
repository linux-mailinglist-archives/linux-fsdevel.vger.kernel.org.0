Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FE35A988
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 02:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhDJAb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 20:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJAb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:31:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B89C061762;
        Fri,  9 Apr 2021 17:31:11 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lV1Wg-00490e-Ew; Sat, 10 Apr 2021 00:31:02 +0000
Date:   Sat, 10 Apr 2021 00:31:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 2/3] ecryptfs: use private mount in path
Message-ID: <YHDxxunCKNuV34Oz@zeniv-ca.linux.org.uk>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409162422.1326565-3-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 06:24:21PM +0200, Christian Brauner wrote:

> Reading through the codebase of ecryptfs it currently takes path->mnt
> and then retrieves that path whenever it needs to perform operations in
> the underlying filesystem. Simply drop the old path->mnt once we've
> created a private mount and place the new private mnt into path->mnt.
> This should be all that is needed to make this work since ecryptfs uses
> the same lower path's vfsmount to construct the paths it uses to operate
> on the underlying filesystem.

> +	mnt = clone_private_mount(&path);

Incidentally, why is that thing anything other than a trivial wrapper
for mnt_clone_internal() (if that - I'm not convinced that the check of
unbindable is the right thing to do here).  Miklos?
