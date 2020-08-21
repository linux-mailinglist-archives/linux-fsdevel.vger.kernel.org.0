Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919D24DE9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHURgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgHURgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:36:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBAC061573;
        Fri, 21 Aug 2020 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=e63rRxO9kfazS7TPx03ZgoZJYy1y5jMIfjZp9EP1Dsc=; b=AYjYxCoZWk7C4vEnleT5ktRrsX
        GzHvPFZRRJ1DuErfBPOV2dbieu8MXOGuqnqwwCHJcB+OKbkhcDdLlUJe99eiePMbwDuqLIK7oPuFj
        xDbPHRoim3d1VNCmxOtYRNmh7tyogRIAEltEvjj4tGC/d6yO2YTvoKpr5vLonMJmcx2J089HY0Tel
        NOsd9AafZ+xz+wE6IEJ3MBa2or4i+OlQoIg2C+Bkp1P1n+1zQr6hVHRAgSboqXYkkIRfZ9dTspyLt
        ujb1wsI2I8TQmmTUn/VtLy1nJ4TPQmoUy34NwtOLFKpkvJA9f/vRBVQqe0OdpVu08b5q6LSC4BENJ
        eJ3JNVGQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9AxL-0005nm-Cv; Fri, 21 Aug 2020 17:36:00 +0000
Subject: Re: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5dfec6f4-0688-217d-587b-ec26f0bb9727@infradead.org>
Date:   Fri, 21 Aug 2020 10:35:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 9:25 AM, Konstantin Komarov wrote:


> +/* O:BAG:BAD:(A;OICI;FA;;;WD) */

What is that notation, please?

> +const u8 s_dir_security[] __aligned(8) = {
> +	0x01, 0x00, 0x04, 0x80, 0x30, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x02, 0x00, 0x1C, 0x00,
> +	0x01, 0x00, 0x00, 0x00, 0x00, 0x03, 0x14, 0x00, 0xFF, 0x01, 0x1F, 0x00,
> +	0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
> +	0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x20, 0x00, 0x00, 0x00,
> +	0x20, 0x02, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05,
> +	0x20, 0x00, 0x00, 0x00, 0x20, 0x02, 0x00, 0x00,
> +};



> +
> +	if (0x10000 * sizeof(short) != inode->i_size) {
> +		err = -EINVAL;
> +		goto out;
> +	}

Please put constants on the right side of compares.


> +MODULE_AUTHOR("Konstantin   Komarov");

Drop one space in the name.


thanks.
-- 
~Randy

