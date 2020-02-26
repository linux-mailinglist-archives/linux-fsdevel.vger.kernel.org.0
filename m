Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B593170932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 21:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBZUGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 15:06:35 -0500
Received: from mail-eopbgr60099.outbound.protection.outlook.com ([40.107.6.99]:18990
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbgBZUGf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:06:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0a3a7EEWusmBwwt0AoM3Cjj2vNP8Ilta76tESxWjR7LWWgnpcpU8sTeCSiz2S/aA9qdoUZnByN6iAfbq/vXfVF0SEkm5tXriHkXxyC+stNAFIVm3Xpb3G3GA3brZ1x3uaw2RCke0aSekilKuGUpU3VY4N3C9ERO+bnQ5P/fB8ZTQZUaZqR2U8P95QncSrwOsFgNcDpUnVz6ij4YTnNxxmnFwxbdTv/sFNvZecQ9EUXgaDbfU6EESz0EafQWDuEwWGbAsioHLfWwyEIrAKT/TGLXze2csaSF7cNhv5Vy5kcPLbOg9WlWgjR6p7gFsvM5ZG2H2mzfq7P2+uuVs/Aydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w1lFPsPIsG/y3jktuT5z7lsNA/KXEsIr2gY8V8GqKE=;
 b=RORp7eZ4nRs781B/29kbdrpwRtRARfrOcQUmcgf9ZpAOPlrpz7rm554WwvLkEu2CUHKoYima9AJ+3bqE3KL6+qZpfcxm4xTDNL+DuEjrwbiFMw4KHrxHJKtG0KK95FGeI1kdppNn0SkHVQwfuAzyX0gH/qS6AVbp7yR7A+iHpycNW07x63YUaIrjeb5C3Cs798A5bceoNw6pOvUiKQO7zBAoaLv2qOgkBfKTyj82C2zJx7UVyZ8R0FaHI7mh9oNmnk5QT+5WJkYKuVOOSo81/umvU8ZFSBvBkVLBHrhLYPML9apr9Hb0jQFx8DZ7l0wje2k0W5s1k3tmZ3Poc1v96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w1lFPsPIsG/y3jktuT5z7lsNA/KXEsIr2gY8V8GqKE=;
 b=WPciydVqEKnwX36Fs3aOuu0134Sr8jLCO77bWmEU/FlScUucJH0GjMISxyQYAvhXmpphq2XERealfOFBcKApeTnzg2fW811ooCQqmnyuxDKoHvVKISkSyTWpiqB1unnDIV9YK7dF++FJr2HVZlLdoJgJrXlB3/L204vMGBoyomo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com (52.135.128.26) by
 DB7PR08MB3755.eurprd08.prod.outlook.com (20.178.45.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 20:06:32 +0000
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::5cbb:db23:aa64:5a91]) by DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::5cbb:db23:aa64:5a91%3]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 20:06:32 +0000
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
Date:   Wed, 26 Feb 2020 23:05:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200226155521.GA24724@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0311.eurprd05.prod.outlook.com
 (2603:10a6:7:93::42) To DB7PR08MB3276.eurprd08.prod.outlook.com
 (2603:10a6:5:21::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.14.212.145) by HE1PR05CA0311.eurprd05.prod.outlook.com (2603:10a6:7:93::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 20:06:29 +0000
X-Originating-IP: [176.14.212.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c21341-7c48-40d6-2da0-08d7baf75fb1
X-MS-TrafficTypeDiagnostic: DB7PR08MB3755:
X-Microsoft-Antispam-PRVS: <DB7PR08MB37556988B2DA3700820E8D2ECDEA0@DB7PR08MB3755.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(136003)(39850400004)(189003)(199004)(31696002)(6916009)(186003)(16526019)(478600001)(31686004)(52116002)(86362001)(956004)(8936002)(2616005)(316002)(6506007)(8676002)(6666004)(966005)(53546011)(26005)(2906002)(6512007)(6486002)(36756003)(7416002)(4326008)(81166006)(81156014)(5660300002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3755;H:DB7PR08MB3276.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAykNBWn75+desrTbAeXW9Y39yxMYgOjG55kKi81rsKCk72uC+zi+22VSDmxuPg4mly2I+j8airmSbyk/MZsOBNFsxA8yr6jfvxsyET9c0Dcmn4oQM7v7mCK3rnvbS4ypsF6SMQoazbtHJZwvFu4vSvoySaDo24i6VNFaTRXVAG+sj/x5UfuvE7tCBEUE8DhW14h6wF7UB49HPiw3apJPq/EJvb6gBCG/h/Aw12simL6hlv+WOslBuh/PPEt/x7TqVWtz5IOd4pIKSO6zKZokw2r+zJmIeZCaGgOJt0hGuqG78+BNltytufdYRYWRPQ2O3gUIHksTOPVNiMGgb+xoJNp5XSsAM8BTEcai0E72pUPu3NUVhEs8f99N2to9k0BmbZalfGdfDAClhDCzDtOPUrcULWDXTN8k3jbv4MXjH+MY17dezPP6jMl1F4M7tcndpjj6bBzni/jF8joAEDhGSjM6lxEbIfSBJDEnCoAs7fjOn8qcMpEOZzrhJ+628IGIeEnNFNEx/nyH3NHFoFlhA==
X-MS-Exchange-AntiSpam-MessageData: 9cbZNs1BC3IdiPAKVP4Tj0sqD3XUZ7KDtYnpDlK0ftMP0YgfwUgfFhy05r9WqmfmCIjrJc5MrGllDBt9QRUK03rTFKTkr8Y0DZBTJiAVGb8kx8BoycvLNms0ked51Lcn5nDdhIJrO2t/cyoR8+5Daw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c21341-7c48-40d6-2da0-08d7baf75fb1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 20:06:32.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWAQ6M+iUd9QPdo9ufUq44iI4PPXxPWCXQgNzWdJesTHpRRH3Yn9XxjJWTgOGVlLq1KLiQwR7ViOuALYAp64Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3755
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.02.2020 18:55, Christoph Hellwig wrote:
> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>> This adds a support of physical hint for fallocate2() syscall.
>> In case of @physical argument is set for ext4_fallocate(),
>> we try to allocate blocks only from [@phisical, @physical + len]
>> range, while other blocks are not used.
> 
> Sorry, but this is a complete bullshit interface.  Userspace has
> absolutely no business even thinking of physical placement.  If you
> want to align allocations to physical block granularity boundaries
> that is the file systems job, not the applications job.

Why? There are two contradictory actions that filesystem can't do at the same time:

1)place files on a distance from each other to minimize number of extents
  on possible future growth;
2)place small files in the same big block of block device.

At initial allocation time you never know, which file will stop grow in some future,
i.e. which file is suitable for compaction. This knowledge becomes available some time later.
Say, if a file has not been changed for a month, it is suitable for compaction with
another files like it.

If at allocation time you can determine a file, which won't grow in the future, don't be afraid,
and just share your algorithm here.

In Virtuozzo we tried to compact ext4 with existing kernel interface:

https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c

But it does not work well in many situations, and the main problem is blocks allocation
in desired place is not possible. Block allocator can't behave excellent for everything.

If this interface bad, can you suggest another interface to make block allocator to know
the behavior expected from him in this specific case?

Kirill
