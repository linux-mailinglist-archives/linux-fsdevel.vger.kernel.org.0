Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91E304936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbhAZFag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAZEev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:34:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED0C06178A;
        Mon, 25 Jan 2021 20:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ulq2RkWd4Zc4VVcs/d9E0B2efDfCWFN4B8z4XvZ8Chc=; b=zHbwUJu7mdhhBACE9JvaHzGgwf
        n9JaMvhN3h4Bgm7dO17Y95S4YziMu90XJNvT06eheTJxkPhjPHhkICEwVXwo7zyThc0eS7qqI5tMZ
        y8zWqVguwXPAGDlUAQRkBleE2d2IqiiWwNl+4y4ByKDhs5IubvAwdyB6qWpj19yUT9GbrPz5bLlsg
        SoHBY3Dm7y8r4mKvjEyO6FYlzSA2PmWAfYq2g9dvZSWx++cCHeLf2jDHTxDdKM+V/VwhcIxhwnOfA
        uM1KMt1GyA2beUzuPDtM+B9XzsXXamFPIGZInjd2McFDcKwxIZg/b3oWBxpgAOinCe+OJffJw3vvC
        njrk617Q==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4G3E-0004Mu-Pt; Tue, 26 Jan 2021 04:34:01 +0000
Subject: Re: UBSAN: shift-out-of-bounds in exfat_fill_super
To:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        namjae.jeon@samsung.com, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000c2865c05b9bcee02@google.com>
 <20210125183918.GH308988@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <40b5993e-d99e-b2b9-6568-80e46e2d3cb1@infradead.org>
Date:   Mon, 25 Jan 2021 20:33:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210125183918.GH308988@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 10:39 AM, Matthew Wilcox wrote:
> On Mon, Jan 25, 2021 at 09:33:14AM -0800, syzbot wrote:
>> UBSAN: shift-out-of-bounds in fs/exfat/super.c:471:28
>> shift exponent 4294967294 is too large for 32-bit type 'int'
> 
> This is an integer underflow:
> 
>         sbi->dentries_per_clu = 1 <<
>                 (sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> 
> I think the problem is that there is no validation of sect_per_clus_bits.
> We should check it is at least DENTRY_SIZE_BITS and probably that it's
> less than ... 16?  64?  I don't know what legitimate values are in this
> field, but I would imagine that 255 is completely unacceptable.

Ack all of that. The syzbot boot_sector has sect_per_clus_bits == 3
and sect_size_bits == 0, so sbi->cluster_size_bits is 3, then
UBSAN goes bang on:

	sbi->dentries_per_clu = 1 <<
		(sbi->cluster_size_bits - DENTRY_SIZE_BITS); // 3 - 5


There is also an unprotected shift at line 480:

	if (sbi->num_FAT_sectors << p_boot->sect_size_bits <
	    sbi->num_clusters * 4) {

that should be protected IMO.


-- 
~Randy

