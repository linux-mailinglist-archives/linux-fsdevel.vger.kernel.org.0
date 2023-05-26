Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297DC712E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjEZUoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbjEZUoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 16:44:32 -0400
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [IPv6:2001:41d0:203:375::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742513A
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 13:44:30 -0700 (PDT)
Date:   Fri, 26 May 2023 16:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685133868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KhM7Tec91IIr/YDqGSLmg2UH0YLVPVmNhygxdKaLXo=;
        b=YdBrJ6M5eG7UsaBjdAHMN8N/fTptPzh6l1+Uq1Fcfevf9lCW+dfJqr98mF+m0jbJYwflwj
        lHEBizbTBG0X8AJzw7Xu9gRnmcXRyBJzYWy65UtzSffRlQM2c86ISnt/yBZ5YYkdURabYm
        dv2YQuUwqMo5t/Fz6g9S9xxW6UCfZVo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Message-ID: <ZHEaKQH22Uxk9jPK@moria.home.lan>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 08:35:23AM -0600, Jens Axboe wrote:
> On 5/25/23 3:48 PM, Kent Overstreet wrote:
> > Jens, here's the full series of block layer patches needed for bcachefs:
> > 
> > Some of these (added exports, zero_fill_bio_iter?) can probably go with
> > the bcachefs pull and I'm just including here for completeness. The main
> > ones are the bio_iter patches, and the __invalidate_super() patch.
> > 
> > The bio_iter series has a new documentation patch.
> > 
> > I would still like the __invalidate_super() patch to get some review
> > (from VFS people? unclear who owns this).
> 
> I wanted to check the code generation for patches 4 and 5, but the
> series doesn't seem to apply to current -git nor my for-6.5/block.
> There's no base commit in this cover letter either, so what is this
> against?
> 
> Please send one that applies to for-6.5/block so it's a bit easier
> to take a closer look at this.

Here you go:
git pull https://evilpiepirate.org/git/bcachefs.git block-for-bcachefs

changed folio_vec to folio_seg, build tested it and just pointed my CI
at it, results will be showing up for xfs at
https://evilpiepirate.org/~testdashboard/ci?branch=block-for-bcachefs
