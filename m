Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162B629558
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiKOKKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 05:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiKOKKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:10:13 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680722F;
        Tue, 15 Nov 2022 02:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668506982; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=CW4l41oR7KZQwFhNoYv0OJy8Cd2JSMsS6ZSkl1BGBJPIFgEtzLbklxeWRT3PjxH8tpznsDCokee2X62/26iUdnNZ1C72IAhauCouyUADqO72AXWPxQCPvNTe9n1CGvl1KpMWE30PFYiKyT098QSsoxyRRy2DC+LHnFP7Q4QkI0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1668506982; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=y0KP37fL06Ddkt/t9va+97Mqv3/Ml7gCQQoFspXKKGs=; 
        b=Nj4LfgTwYNFtHzNUDBzXcaNRFOI6OdF0Pv4hvEH9ULQjLaGvsErMhAGL9GzwgFS9tchP5+iYkIgDcaReIZJyhvk25AX2Xqodcf0bLke1aFn7MIcYobCOM5IBoPxd42MdnQaWcHVUIIUulrUCgxpiDB4lulEw35C0S867R6txvnw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668506982;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=y0KP37fL06Ddkt/t9va+97Mqv3/Ml7gCQQoFspXKKGs=;
        b=qU1QmqMLateIUL8kOybJ2pEVqylDaGtjC9kT5vxZrcCITWUILt5Ti2Uq8YcOzNGT
        9fsqOq2xXeezL2rCGfdytpYZ2AYct4lYgSd3H+KaLTnwsnv1Ls2nXGIa0l69J+d+ftg
        31DTok8axZF+bZu71TwZZNMVzmOhPQHIvU12rQwA=
Received: from [192.168.1.9] (110.226.30.173 [110.226.30.173]) by mx.zoho.in
        with SMTPS id 1668506981538751.4796566831048; Tue, 15 Nov 2022 15:39:41 +0530 (IST)
Message-ID: <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
Date:   Tue, 15 Nov 2022 15:39:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
> I just wonder if we should return -EINVAL for post-EOF cases or
> IOMAP_HOLE with arbitrary length?

Since it has been observed that length can be zeroed, and we
must stop, I think we should return an error appropriately.

For a read-only filesystem, we probably don't really need to
care what's after the EOF or in unmapped regions, nothing can
be changed/extended. The definition of IOMAP_HOLE in iomap.h
says it stands for "no blocks allocated, need allocation".

Alternatively, we can return error iff the length of the
extent with holes is zero, like here.

Thanks,
Siddh
