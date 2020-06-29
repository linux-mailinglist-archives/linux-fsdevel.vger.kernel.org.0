Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE120D74C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgF2T2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbgF2T1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:49 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C3C02A56A
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 06:27:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 80so15178119qko.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2AnTF15EPeYmt2Yp9Y7WXtZdlZv68c4VAMoUVc2+4D0=;
        b=BAlBiQXTwyDXKy5kV25+geXA3BB4aJVrabw5hGGBruvOt8NfU6hTysJbNnK4yMNWeM
         QJ5NAUV5XwjJo8iLLWoK9nByxYGgtYnNrKuMd5Sjr+FCeSBN9DxsQE0HiPp7XFCxJvN/
         9csCZu9JCnux7fMiFnihSFm0nfdbOIXpRLw8L/y3Glku5eBA6iM7VqF824owHouel29v
         vrkeSlKaV6kB1VnNgu7OPIW8gKzoAThFJLoZWGINJPBuyJTwyug2P+j+8TjdoSEd+8Uv
         aXEBr2jW4F0msCSyz/KkHR7tGVDOZS2y4tTre97ULmQx+oNSR/BqtQuydwIb9SGO2wKo
         QGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2AnTF15EPeYmt2Yp9Y7WXtZdlZv68c4VAMoUVc2+4D0=;
        b=JbrCgagMgb6px6/5+HkI0mq68zscjczxPIWFXW2Ww8RVg9eLDpGAj4jwLLmjudqEwg
         9979t2426iILuBWDjLkWhNi4dVWSuv1PoUF7QXsLAohxrLAORKkkij1tWM/CnXb3BCRU
         CWfACkgeR5yRArrc8xQSKO5a3kP0nmcSQJlPKd3FNNz88TsYliFW4XRDHDhHtkdIRCs+
         8Y9qWZm7HTxZolWhInq+JXj8xANaH99zq4ZSOjosafHQ3CJmh5OzHOvwvDd7Ra5ibvra
         Kt9ZMVOCCZBwHExLiMSqSoB8IYEURI2EfIjqz6oQdxuVC1NDEf1DTHwIgwEicLuc0wHn
         dqAQ==
X-Gm-Message-State: AOAM530yXnVxUunQNmBQPYiYERgF7c76+s+BMC9ytZhm+ABeEMtKexZz
        g3qvhWPeJZc97UNaT/Z2yQk=
X-Google-Smtp-Source: ABdhPJwvteiZE4xthkxfkWjrcvBCNXUZ0xxrBa9EVpFIqtr1/cR/SWsQUp0z4HNNy5AHO8/aMqxddg==
X-Received: by 2002:a37:4d0f:: with SMTP id a15mr14894469qkb.313.1593437271283;
        Mon, 29 Jun 2020 06:27:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:26be])
        by smtp.gmail.com with ESMTPSA id j7sm16623259qtd.53.2020.06.29.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:27:50 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:27:48 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/20] kernfs: do not call fsnotify() with name without a
 parent
Message-ID: <20200629132748.GG13061@mtj.duckdns.org>
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

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
