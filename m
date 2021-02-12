Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92544319ADB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 08:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBLHsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 02:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhBLHrq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:47:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E66064DEE;
        Fri, 12 Feb 2021 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613116016;
        bh=V5VmSoU6jzgdBUBGYUFsqrWJOs4ufbyeLq3ulBd68Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6yypRUVOhMMgeyh/U9LtFuNLEe6UEJ0mpIyLPj1yWUysz/TkxGifb+vrGoWItc9j
         eujH4jnHSfPamC6y6mvLoPfmDinJDwdO95C/SmOIHE7vrOUDRsvoBPW3Q82n/cDEfa
         kY+Y9o2CpyhZ3j2osBVZ7P7NnaIPpeTTbA/66Z0w=
Date:   Fri, 12 Feb 2021 08:46:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <YCYybUg4d3+Oij4N@kroah.com>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> Filesystems such as procfs and sysfs generate their content at
> runtime. This implies the file sizes do not usually match the
> amount of data that can be read from the file, and that seeking
> may not work as intended.
> 
> This will be useful to disallow copy_file_range with input files
> from such filesystems.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> I first thought of adding a new field to struct file_operations,
> but that doesn't quite scale as every single file creation
> operation would need to be modified.

Even so, you missed a load of filesystems in the kernel with this patch
series, what makes the ones you did mark here different from the
"internal" filesystems that you did not?

This feels wrong, why is userspace suddenly breaking?  What changed in
the kernel that caused this?  Procfs has been around for a _very_ long
time :)

thanks,

greg k-h
