Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15313662130
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 10:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjAIJOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 04:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbjAIJN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:13:28 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0313FB9;
        Mon,  9 Jan 2023 01:10:25 -0800 (PST)
Received: from [192.168.1.103] (31.173.86.218) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 9 Jan 2023
 12:10:15 +0300
Subject: Re: [PATCH RFC v7 08/23] dept: Apply sdt_might_sleep_strong() to
 PG_{locked,writeback} wait
To:     Byungchul Park <byungchul.park@lge.com>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>,
        <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <will@kernel.org>,
        <tglx@linutronix.de>, <rostedt@goodmis.org>,
        <joel@joelfernandes.org>, <sashal@kernel.org>,
        <daniel.vetter@ffwll.ch>, <duyuyang@gmail.com>,
        <johannes.berg@intel.com>, <tj@kernel.org>, <tytso@mit.edu>,
        <willy@infradead.org>, <david@fromorbit.com>, <amir73il@gmail.com>,
        <gregkh@linuxfoundation.org>, <kernel-team@lge.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <mhocko@kernel.org>, <minchan@kernel.org>, <hannes@cmpxchg.org>,
        <vdavydov.dev@gmail.com>, <sj@kernel.org>, <jglisse@redhat.com>,
        <dennis@kernel.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <vbabka@suse.cz>, <ngupta@vflare.org>,
        <linux-block@vger.kernel.org>, <paolo.valente@linaro.org>,
        <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jack@suse.cz>, <jlayton@kernel.org>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <djwong@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <rodrigosiqueiramelo@gmail.com>, <melissa.srw@gmail.com>,
        <hamohammed.sa@gmail.com>, <42.hyeyoo@gmail.com>,
        <chris.p.wilson@intel.com>, <gwan-gyeong.mun@intel.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <1673235231-30302-9-git-send-email-byungchul.park@lge.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e8b24129-536c-a367-1436-fe0e054259cf@omp.ru>
Date:   Mon, 9 Jan 2023 12:10:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1673235231-30302-9-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.86.218]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 01/09/2023 08:47:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 174559 [Jan 09 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.218 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.218
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/09/2023 08:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/9/2023 6:18:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/9/23 6:33 AM, Byungchul Park wrote:

> Makes Dept able to track dependencies by PG_{locked,writeback} waits.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  mm/filemap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c4d4ace..b013a5b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
[...]
> @@ -1226,6 +1230,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>  	unsigned long pflags;
>  	bool in_thrashing;
>  
> +	if (bit_nr == PG_locked)
> +		sdt_might_sleep_strong(&PG_locked_map);
> +	else if (bit_nr == PG_writeback)
> +		sdt_might_sleep_strong(&PG_writeback_map);

   Hm, this is asking to be a *switch* statement instead...

[...]

MBR, Sergey
