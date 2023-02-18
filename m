Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE069B8CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBRIuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRIuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:50:14 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008F4BE8E;
        Sat, 18 Feb 2023 00:50:13 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 997A6C01F; Sat, 18 Feb 2023 09:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710235; bh=sXdImI4nkNQNTEPrwVQoa5Yw0dY8HCwd1vHRxqYPKJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QL+JBVm61ZHbZfpzS0z30/QJHPq2fa/YzotMPK8iFUJLStoBdU3CvTEX2jzEnYuyw
         6z+Y096nExUAvDDhRe/fdtFaQJYXFvpllyfTWLbL2Yr97I3VlnxjKukaYrL6YwCr3l
         yN7PWCPPBryhmUlfmN/dFxmI+JfDwDgj5yvTd096tuMOtF0hz092kED9hdixeyWaip
         dgGQ+WsT4LMzOERnG3ibRkMKZDnhBNe02YYZGhNCLlrPm4wzqxOXXCf9gw3RRCTkap
         H8IUTwS1+E4v+Wrjhc4+T/cN5lREMVLiBZC+XotGEfNUbbPPgkyEF2Zti42MqvzLzu
         rozfzpcr/sK6w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 14017C009;
        Sat, 18 Feb 2023 09:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710234; bh=sXdImI4nkNQNTEPrwVQoa5Yw0dY8HCwd1vHRxqYPKJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzl1CnpZNMJWsCQVMYsRbq3nj3xhcmrEDd46AQZjNYKstgvhUqU5mnLsB09u/5Kr1
         Bs9JG8rQBU/IOlCHxv6LLcWyK0HfNk/1lEG1su3KzncFwiIBRHsAzHbkCUOMChK6wV
         xW9CpXh09lGoDMnXmGr8TcXy9bFxgw0uENfHiwFxYGKBPOacHo10AXGnYEkAykR9xy
         IeuibZbKtpopP7VE05IsStciz+JQqmbxalu6Vf3Ris23cezj7Jbrc34bYBiqmE2QPX
         c+WzICD5d7zcnPOTWBb5opd8D4ctI5VNpv1Rm5CSa8sXXXuYl6vexboUGwa4UA33Xo
         cRAycGsYP0ojQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 271fab5c;
        Sat, 18 Feb 2023 08:50:05 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:49:50 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 09/11] fs/9p: fix error reporting in v9fs_dir_release
Message-ID: <Y/CRLskZ7QOROVWk@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-10-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-10-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:21AM +0000:
> Checking the p9_fid_put value allows us to pass back errors
> involved if we end up clunking the fid as part of dir_release.
> 
> This can help with more graceful response to errors in writeback
> among other things.

That is good!

Note if there are other refs we won't see any error :/ But I think we
should check p9_fid_put return value way more often, even if all we do
with it is print a warning at some debug level for context.

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

--
Dominique
