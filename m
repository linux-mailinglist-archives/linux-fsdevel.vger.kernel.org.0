Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121A86CAD19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC0ShK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC0ShJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:37:09 -0400
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDCB3AAF
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:37:08 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679942226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7o6r6784pPUO2ZmV+U6zKpq4kzlG08gwo4Hlwv9hSrU=;
        b=sdQo+TK60P7btFfKoJ71OOACvu1F3dGGHIpQoL0hPQbcScul6bOD8kiwsGjTgIWcy+h+6w
        YFL/ZLGiU2b/OjG2Dy3wWTacnrE++v1Lns5Aj1fcP4BeqND/dIdqa8zLImgln2jniLX752
        g/Rgzu1ONn6bp1u0apPqxA9ek7wreqY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v3] fs/aio: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <ZCHiTYyzBzHFa9xX@moria.home.lan>
References: <20230119162055.20944-1-fmdefrancesco@gmail.com>
 <2114426.VsPgYW4pTa@suse>
 <ZCGYps2z5IlaEaxU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGYps2z5IlaEaxU@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 02:22:46PM +0100, Matthew Wilcox wrote:
> Or should we just stop allocating aio rings from HIGHMEM and remove
> the calls to kmap()?  How much memory are we talking about here?

I don't think that should stop us from taking these patches, but yes.
