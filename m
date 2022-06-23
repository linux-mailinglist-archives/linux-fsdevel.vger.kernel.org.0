Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152505571F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 06:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiFWEoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 00:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiFWDst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:48:49 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94E3DA6B;
        Wed, 22 Jun 2022 20:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=EDunuY7O5hAPgL1BhKSksPMMhIIfJXz8txcUJNIwT/A=; b=erkQTTzYczL6JKF7+aS3kheQC7
        Am8cmBiVmdHnbXS/z2EOVm39y3Ovj+pKNOVC1RDpRA6lhMm5krp/v/VW5NK0rksnSYPjxDEwkHfQQ
        j3VYDgbmodwl5Z7t4S2qgItpkJAuBxg45OaEzhr0mqMrYJRk/iUDc3drmLccxCX/TugAVOf6QPgqs
        mNibyIKdPnWBH7Nla73/rgAhZA/bZAPQ2FiP5MNps4HYT1EM1m+EuF1p7rpG9Ig2U7r9tqwcdElLs
        5fzbETCMmB6F1GGmgl0BkwtJXTAX7VSzAsLT/GaK4BOz1BoSou0wehHH4jDWMS0uqaQJR7LZT/9V1
        ZCB4oGxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o4Dpk-003Pd1-W8;
        Thu, 23 Jun 2022 03:48:45 +0000
Date:   Thu, 23 Jun 2022 04:48:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     sunliming <kelulanainsley@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunliming@kylino.cn
Subject: Re: [PATCH] walk_component(): get inode in lookup_slow branch
 statement block
Message-ID: <YrPinPcHHNfv3E3B@ZenIV>
References: <20220622085146.444516-1-sunliming@kylinos.cn>
 <YrLwU27DNm0YWOvB@ZenIV>
 <CAJncD7RuTTLoRS_pzvn729_SX5Xsv6Pub44eCD_RbbANjn9joA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJncD7RuTTLoRS_pzvn729_SX5Xsv6Pub44eCD_RbbANjn9joA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:44:29AM +0800, sunliming wrote:
> Al Viro <viro@zeniv.linux.org.uk> 于2022年6月22日周三 18:35写道：
> >
> > On Wed, Jun 22, 2022 at 04:51:46PM +0800, sunliming wrote:
> > > The inode variable is used as a parameter by the step_into function,
> > > but is not assigned a value in the sub-lookup_slow branch path. So
> > > get the inode in the sub-lookup_slow branch path.
> >
> > Take a good look at handle_mounts() and the things it does when
> > *not* in RCU mode (i.e. LOOKUP_RCU is not set).  Specifically,
> >                 *inode = d_backing_inode(path->dentry);
> >                 *seqp = 0; /* out of RCU mode, so the value doesn't matter */
> > this part.
> >
> > IOW, the values passed to step_into() in inode/seq are overridden unless
> > we stay in RCU mode.  And if we'd been through lookup_slow(), we'd been
> > out of RCU mode since before we called step_into().
> 
> It might be more appropriate and easier to understand to do this
> before parameter passing in the top-level  walk_component function？

It's possible to fall out of RCU mode *inside* step_into(), so we need
it done there anyway.  Unfortunately ;-/
