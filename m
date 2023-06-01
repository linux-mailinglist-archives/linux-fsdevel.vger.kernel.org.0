Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927F71A3AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjFAQFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjFAQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F66B3;
        Thu,  1 Jun 2023 09:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27BE64724;
        Thu,  1 Jun 2023 16:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392AFC433A7;
        Thu,  1 Jun 2023 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685635491;
        bh=9VVhtE+h1olCMH+eToJqAsc27fiBafH1FhgqqxR9pNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFrsjpMaETqDYTZ68oSD2CnSmqYkvfJRZxBgInCMrtdkSdZBAgo6FHv/jTLRQ8CuC
         xLatnffnRgW7SoQ2hoiVC/7B8cE6P41HbYkz0DmMr+nSvVkZosegWy332KanmMw28n
         Zixzjim4NlNaOD5ZQYdtA2lgnwkgCL+g4vYsIpTFHfmB3RjwmzTsihKpy4/3HLe8tl
         kK8zclhvEHkQNCa7TJMQ4/BDikF8QKK81XMHmbt6w0gu9zD+yd5nK4lBjAklGixcsg
         x3HPvkK03noL5asjuvqwApTPjPJA/sAjoWGcn0V924p+L/hpTjFBFfPCx1h3OTyiTO
         QatKNTFjelFTA==
Date:   Thu, 1 Jun 2023 09:04:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230601160450.GB16856@frogsfrogsfrogs>
References: <20230601094224.1350253-1-hch@lst.de>
 <20230601094224.1350253-2-hch@lst.de>
 <20230601152536.GA16856@frogsfrogsfrogs>
 <20230601152740.GA31938@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601152740.GA31938@lst.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:27:40PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 08:25:36AM -0700, Darrick J. Wong wrote:
> > > +_require_scsi_debug
> > > +
> > > +physical=`blockdev --getpbsz $SCRATCH_DEV`
> > > +logical=`blockdev --getss $SCRATCH_DEV`
> > 
> > These two tests need to _notrun if SCRATCH_DEV is not a blockdev or if
> > SCRATCH_MNT is not a directory.  Normally _require_scratch_nocheck takes
> > care of that.
> > 
> > Other than that they look ok.
> 
> Can SCRATCH_MNT be not a directory?

Good question.  AFAICT the only checks on it are in
_require_scratch_nocheck itself...

> But yeah, these tests should simply grow a
> 
> _require_block_device $SCRATCH_DEV

...but you could set up the scsi_debug device and mount it on
$TEST_DIR/foo which would avoid the issue of checking SCRATCH_*
entirely.

(Please remember to _require_test if you do though.)

--D
