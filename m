Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE684D0010
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiCGNbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 08:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCGNbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C77EA0B;
        Mon,  7 Mar 2022 05:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E84B81243;
        Mon,  7 Mar 2022 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00802C340E9;
        Mon,  7 Mar 2022 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646659816;
        bh=oBLz9AgNUk2wIEBHGy6U9s99emBLztMRAodnUzUj5w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFCk7udNm2J44RTzfUJ+MfPwopHSW/nmauJl4OmAbMfrWN2sP0SwIOWXTFvBG7ITK
         ZckklcNFLR5z7x04rHy7YPPgl/p5kkHiqVMVYe26/xj40ZZ/jSJS6b2bBHs4cT+qlg
         lSryt84BjNDG2rf9ETJvTM0G+a+p4bQl/Xod+mFKXtsAk8t/TDHR0+xtUPhy5OHE2n
         RV7OiySPImo+g4q9DZSj1HLZYgcZTUZlg7l86k4mMgBlrwGy8WT95FerjuTQ/xJ2ij
         Fs2tnxaydRH2XVd9fVLVS75/YXpyxiD2u+Dk0fyp2LN6w5OcLV76rEDlCEotG1qXaU
         ODeQnJrvkkvkg==
Date:   Mon, 7 Mar 2022 15:29:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>, G@iki.fi,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-mips@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
Message-ID: <YiYIv9guOgClLKT8@iki.fi>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <YiSb7tsUEBRGS+HA@casper.infradead.org>
 <YiW4yurDXSifTYUt@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiW4yurDXSifTYUt@infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 11:48:26PM -0800, Christoph Hellwig wrote:
> On Sun, Mar 06, 2022 at 11:33:02AM +0000, Matthew Wilcox wrote:
> > On Sun, Mar 06, 2022 at 07:32:04AM +0200, Jarkko Sakkinen wrote:
> > > For device memory (aka VM_IO | VM_PFNMAP) MAP_POPULATE does nothing. Allow
> > > to use that for initializing the device memory by providing a new callback
> > > f_ops->populate() for the purpose.
> > 
> > As I said, NAK.
> 
> Agreed.  This is an amazingly bad interface.

So what would you suggest to sort out the issue? I'm happy to go with
ioctl if nothing else is acceptable.

BR, Jarkko
