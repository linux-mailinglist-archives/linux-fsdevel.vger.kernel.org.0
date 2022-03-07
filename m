Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0BF4D0287
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiCGPQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiCGPQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:16:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0378C7C2;
        Mon,  7 Mar 2022 07:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A15C9B815D7;
        Mon,  7 Mar 2022 15:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9BCC340EB;
        Mon,  7 Mar 2022 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646666160;
        bh=wolcnwajA+sQ1qIY2qVSpKkxIr9b/4/6DCUMi6L+z3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMJbeZdu2XAur6tsZsh5zr5GlKzvMSkxIIbhNs+yYhSVAnH2NH8PuShMKloIdYRm9
         vJWTjuF7yIjrzAamoXCVtwnip18ier3jYS+mBi5doqJJ8x/257SuOfHGx6pQMPc8Ai
         z4WNWB6PAK0R2XPy28O4Qb4HHLcYeP0U7x25v/Yp9XDkLg5DS8Mj2SqQyuXoNiwocM
         B4q2NmFRKKbN7VD1CasygRB/KwUbfgwMvZrQWbTv1X5FHR9i89Jj0fQWRZc5BaCTQI
         W5Hyb6vC4g42XB2FaUVEclWP4wNgkAMIdLkKqjB04hDsQbe/xDCGp3PtK7CYfUT2fJ
         KW76dWktINeLA==
Date:   Mon, 7 Mar 2022 07:15:56 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier González wrote:
> As I mentioned in the last reply to to Dave, the main concern for me
> at the moment is supporting arbitrary zone sizes in the kernel. If we
> can agree on a path towards that, we can definitely commit to focus on
> ZoneFS and implement support for it on the different places we
> maintain in user-space. 

FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so it
looks like that requirement for zone sizes can be relaxed, too.
