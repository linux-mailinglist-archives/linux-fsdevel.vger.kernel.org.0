Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E614D1606
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiCHLSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiCHLSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:18:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1AB46164;
        Tue,  8 Mar 2022 03:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF49D615E6;
        Tue,  8 Mar 2022 11:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD81AC340EC;
        Tue,  8 Mar 2022 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646738235;
        bh=zbUtFRfgQPHfCSQlUjGperKHsTrz12GnosSSKC4zDzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzoi82tmUMolQqy8+u9b1daC0kOsq6GUBIP1lGxuHde3jJBAm8IQrvcSm2PI94DPM
         UWMDn2bMJr9jGGcPvNnjIzUWLztQZ0Z3hstX+y+4uTAlRHNmeW46F8OIa2T3FoRgfF
         tR/34n1q1otBfKkJH62411XpnxQTzktPJgp3XzWd9QHN4UgOY8K0b49AS0AdC3xzqp
         M0sH/K3y1AwdksYCFoqnNm7P9OQe9lWcyhY+SHz5hZkP6KTQkItTzQquqXPTA0tXLv
         qH8XGKX9Jw5ZDgahW6O4y1RMWsUCp7lpM3saEKp1cOg4ijs8z9Y7v4Cov8K2Nfl+hP
         QbI8BEaUH/B4w==
Date:   Tue, 8 Mar 2022 13:16:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC v2 1/3] mm: Add f_op->populate() for populating
 memory outside of core mm
Message-ID: <Yic7Ep2tOdq/oXPt@iki.fi>
References: <20220308111003.257351-1-jarkko@kernel.org>
 <20220308111003.257351-2-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308111003.257351-2-jarkko@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:10:01PM +0200, Jarkko Sakkinen wrote:
> @@ -1619,8 +1622,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  		 * range with the first VMA. Also, skip undesirable VMA types.
>  		 */
>  		nend = min(end, vma->vm_end);
> -		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> -			continue;
>  		if (nstart < vma->vm_start)
>  			nstart = vma->vm_start;
>  		/*

This was unintended, i.e. leaked into patch by mistake. I'll send an
update. There was one diff missing from staging area.

BR, Jarkko
