Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11BF69B8D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBRIzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRIzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:55:42 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7483C792;
        Sat, 18 Feb 2023 00:55:41 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id BD4A6C01A; Sat, 18 Feb 2023 09:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710563; bh=rmDypawu+51PJyFLO+R0QGTEt+vCIzj5+qIOxEvcCX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROEtQMleKCNI9GkdeyWu/+8EX3Ujw/BkNBRyFE6GK//56etGh/icAKrjn961k2Nyd
         MhpEmyWbZL3ULYCnhwKPQC9ZMSrUmma2vVWymGo4G9kq4Eii96Rj7e52MACtJQbUxt
         Rcg/u1WSVxjEuE0+ZmFhSz1GwClnwU7ErhDw+lRAhkqta8uKyKTNgId3oaFXEeq5FC
         6/Ih+RJp7+4/Ir1hAN173co00GQjfq0XD5B9gBV8q+1yBtMA/5iaFcxdZ9AO+b5Pyd
         T2wKZNvIzDIcmKjUDqdJHAT251jtJoFoOzIYt2UEZny8WDttOxKhE2W+pWjt919Qmr
         S/K2RYPcKMSCw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A1C80C009;
        Sat, 18 Feb 2023 09:56:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710562; bh=rmDypawu+51PJyFLO+R0QGTEt+vCIzj5+qIOxEvcCX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbWNlrezX4KzLObMiKvKPYPks6rFHMwAQOzMjigQfxPQzePwn0+ryk3GxPdFQJ1qB
         K/Czcu+KZmn5KMHFQDrASzDXZXX7+no1FU08cUJKq59glD3JHVid23hxVTHFubiZSH
         6PBbaNRklnxqTzVBCpWKqBatSiyNJIYLt4PKjD3JYQmSihN8Bru50QRtJRo4sG4t68
         xAu2n171LPHGsplsuJeK66WL/cvx/gMIMQqNy8a4nuSwFfqlPUUNfUa+GWCy5/NN/P
         eSkW4xvT9m251N5BoAzYQyb4+yEU5ZJRmDmiIz01MM2n6SgpPHXTQXyWkH1/OE7J2T
         ACd8DGtWvekdQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 744eb814;
        Sat, 18 Feb 2023 08:55:34 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:55:19 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 11/11] fs/9p: Fix revalidate
Message-ID: <Y/CSd2oYO9dBbVUH@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-12-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-12-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:23AM +0000:
> Unclear if this case ever happens, but if no inode in dentry, then
> the dentry is definitely invalid.  Seemed to be the opposite in the
> existing code.

Looking at other implementations of d_revalidate (ecryptfs, cifs, vfat)
it seems to be assumed that the inode is always valid.

I'd just remove the if, or if we keep it add a WARN or something for a
while so we can remove it in a few releases?

(That said, it's better to return 0 than 1 here, so don't take this for
a no -- progress is progress)
-- 
Dominique
