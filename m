Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB820D48A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgF2TJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbgF2TAU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3478625586;
        Mon, 29 Jun 2020 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593447098;
        bh=SsCIgboIh8MwG59svpDcWx6ceBeWIXunSMvUsAXqGmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykePTvgrdPFZQukrlOu7yodEStnFvpYDYm3C8XTl6GP7/ObdeVffikq9Uf0ZgQund
         tnKNp0ZPHR0ZXTbRcjuTfkfcHZjXVuOHvRWCeI86Zbi4xJ5G7Gz8QxOae4WwVXwTHw
         aVBWoHudzgee/57w8Io6JWTfCH3rqZuPueMYOUMc=
Date:   Mon, 29 Jun 2020 18:11:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 05/20] kernfs: do not call fsnotify() with name without a
 parent
Message-ID: <20200629161129.GA629636@kroah.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
 <20200612093343.5669-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612093343.5669-6-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:33:28PM +0300, Amir Goldstein wrote:
> When creating an FS_MODIFY event on inode itself (not on parent)
> the file_name argument should be NULL.
> 
> The change to send a non NULL name to inode itself was done on purpuse
> as part of another commit, as Tejun writes: "...While at it, supply the
> target file name to fsnotify() from kernfs_node->name.".
> 
> But this is wrong practice and inconsistent with inotify behavior when
> watching a single file.  When a child is being watched (as opposed to the
> parent directory) the inotify event should contain the watch descriptor,
> but not the file name.
> 
> Fixes: df6a58c5c5aa ("kernfs: don't depend on d_find_any_alias()...")
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
