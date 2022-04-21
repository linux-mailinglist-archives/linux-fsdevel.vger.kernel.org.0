Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11DF50A5EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 18:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiDUQka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiDUQk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:40:29 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D3488AC;
        Thu, 21 Apr 2022 09:37:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 580AC3703; Thu, 21 Apr 2022 12:37:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 580AC3703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650559059;
        bh=vAcRySFdumALaaVWKny6dDU8KH6biyqZJFhn8cyzt9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNODiQ1YGnETuZiW13Y0U9eyPig5J9Biffl7RQreml0Dts6gDt31KzlI2uQBGBcfV
         2wEE4ENimNbrfNCkZIHcTJa2wHbytoRSthqIBoRLDi6E+9yRi14cUxeBCQdL2q7emW
         qgNpjlz13zc/bXmXGitwyxgmaINXQL5gBkWPfxo8=
Date:   Thu, 21 Apr 2022 12:37:39 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 4/8] NFSD: Refactor NFSv3 CREATE
Message-ID: <20220421163739.GA18620@fieldses.org>
References: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
 <165047934027.1829.4170855794285748158.stgit@manet.1015granger.net>
 <20220420191042.GA27805@fieldses.org>
 <D7DC153B-F946-46EA-9A02-B29B0FE6EDC4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7DC153B-F946-46EA-9A02-B29B0FE6EDC4@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 07:31:09PM +0000, Chuck Lever III wrote:
> > I wonder if it'd be
> > possible to keep the two paths free of complications from each other
> > while sharing more code, e.g. if there are logical blocks of code that
> > could now be pulled out into common helpers.
> 
> I'm open to suggestions, but after the final patch in this
> series, I don't see much else that is meaningful that can be
> re-used by both. nfsd_create_setattr() was the one area that
> seemed both common and heavyweight. The other areas are just
> lightweight sanity checks.
> 
> And honestly, in this case, I don't think these code paths
> are well-served by aggressive code de-duplication. The code
> in each case is more readable and less brittle this way. The
> NFSv4 code path now has some comments that mark the subtle
> differences with NFSv3 exclusive create, and now you can't
> break NFSv3 CREATE by making a change to NFSv4 OPEN, which
> is far more complex.

I can live with that.

Also, this passes all my usual regression tests, FWIW.

--b.
