Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441F6E3D14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 03:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDQBGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQBGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:06:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6242213D;
        Sun, 16 Apr 2023 18:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hicf0OrkKVp5YcX0Q7NpKye3/POBZt9UfZYoLTazWDxhTc7HvsvhzkYh9u6auUMVBVBnIKI1Reav45Upab153Ex4YEKyBNsp8HFyi7vG+SAok/x9VMIWS8JL5zk0wzqfny828rUA30amLNSartx5p1BqImJkvN8C0qV1NsprDyJ6+2hbVtYevnZmo1iNuAFlDiShwgmjGLC53RCIusRwt8keGBYsHOdAm7BhlXYhTegivd/0L8WqY2QKVlyoIoVkYZH6K9mI8RNOUE/lbAjLmIRcY74HZCpLa+ELhaX1c7ZxIMM5zFb0ugE78wA+rWrDp5XWtJ+cg0gCQEmSLMk+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s084YyqkAbH9fOmp945tsfX2FJHTbkRY8pGFJfdOiTQ=;
 b=AR+7gMBIfXOQkWwk31Kvo8eG3e2QRv4sSpRvCOYGqx639ZWWpVaf40OXk8pizsQ+XSs7/fGhunyLfkzeOMyWrYwm3sHRAMST477ctnJjaNpIo3IoiyARspCM7v20WN0yIrXnecI/ZPrHnj3nP8iSnxjvI2lMbmqC6G/cy6e16EMXo5n9i2tEsueNlIaC/H7ZHhmjviwB6rfl5wCFsbRHoYn9KldUhK11zasosyeI8SntU69oNqwhfaw76G6pyuRm+SCTmiWVcwSExOPNHGhOwgHFWvt84MRQ0q03r19J6R01MyMY7fdMrnOkk0a340pHnckXq7+SRVKqY54BWVgkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s084YyqkAbH9fOmp945tsfX2FJHTbkRY8pGFJfdOiTQ=;
 b=H9gclq3S2y5oUWcme7wE+zPBw5xyWnZ/oFtxuLEbvGbmhuzM3MPxg4d296Fu6L+N10E0iVbEVHXqv2ukYPA1zPMib3YzLxgkS8REaBE5JjqYNptxREUtV64OBmgzuAWCUbP2TCS+Ii8PDUh8lZzAerUhMdsyDM2apO0EkNjaRw/ou9fwWiuXlnsDJbu/YIUApk64UbMYXLhj/1ouxF68o/aOnUZ4uWs2R6xGwGxDjNF9lWoe5QK9fC0BkIiGK+IhYTwLg6TmXGoQer2lttHukd3MEzN5vEaM7CbJuzwDy1SJDyQDFD2c58/65yDk09LhbRw0ir3mrDRELQkCZk/0+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 01:06:34 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7%7]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 01:06:34 +0000
References: <20230414180043.1839745-1-surenb@google.com>
 <ZDmetaUdmlEz/W8Q@casper.infradead.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page
 can be locked
Date:   Mon, 17 Apr 2023 10:49:31 +1000
In-reply-to: <ZDmetaUdmlEz/W8Q@casper.infradead.org>
Message-ID: <87sfczuxkc.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0133.ausprd01.prod.outlook.com
 (2603:10c6:0:30::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c508e9-5e2c-4b37-8bab-08db3edffc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spYb51gWUKGF8lN33rWABp910okXj9GKu+u2fNNjpeCM2BaYXCOrYB+5dFoLJYmKO5jTfIgMvwqn1g9NUrA7yU9jDwTxPZgSLTg/B4QFIno+JLy4cRxnZwUaNuxdIln5UU1h5cp+o3BpiPKwunG+mOiYLBYkLkpSb5UuNb+/XjKCXCNVe0arp70AifSe2svFZIB3jD+sIw9QdPai4VLoZh4A05wOv5hZzXH9JsuoXP92TRDZKpFoEZAGiUaDHt3i7UHTkzQd9wbv3MVbRkTLEAE4kh5OVfuOOHSxSqe5KX9GG7fwuAYhP/JYSX2D4pFnLcVrGzaTeMHX8qvd3jqTp02PwXHQNvGzRYvQKq90lCFkQQae/QhYwEivmb+WSTBUENFqvztCcIrd61SwqvPOPTrh6NYzQAGFFImsdQRNxSqUln8xByc+3AI5Lt78Hxoq+9hVqrTkOL15l/+GD3firOlN7qih4yOd76Zd5fugVatmZc53atx0D1TIACUdEaMn6nONKa03weusW5ksWsdpXkpkb5W03BmWcnSMnTKR6QIHBrKr/X+e+cyuFgNmS92Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(478600001)(6666004)(38100700002)(66899021)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(66476007)(66946007)(66556008)(186003)(2906002)(36756003)(6512007)(6506007)(26005)(86362001)(83380400001)(2616005)(5660300002)(6486002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+i6c/GO5cMWPVydXR1kEMCw2lTQLLVtMXEc4RZxwaxJHMz4oMCUVHZ5sUIbV?=
 =?us-ascii?Q?d0CmaheMN/IVhvwSu+7BwXRL667Wj7Wma0DJnj6isr2WCxtk3wOSP+JhublA?=
 =?us-ascii?Q?8tYVtTAXJcwxByiexJdfEyide4B6Rl7NEZkQVT6o4GhhUi8M+Tpds5QGZ6dR?=
 =?us-ascii?Q?iQiOi5xdIxcInCMC1TsHzuPpKIPMklAVyhamRKomEHjgBVYZ87F7tqtQJuXj?=
 =?us-ascii?Q?4XwAtMRRZwmYmnb3ieLAw8nwWHGG6T5ZecESa83pRirHxxVL3RvZrA0vRSYS?=
 =?us-ascii?Q?3jm/Qqiy/s7f9zPBlRbvJsVR5H2u9zQaGF6MdK6j9r9BQabNPSQdgUNp1s7s?=
 =?us-ascii?Q?e/FWGghC/yDRz4/TCrFDZMK5B3xX9Y9rkvQa5cjL4E5GpdHUTR14znozyUr0?=
 =?us-ascii?Q?sQ6Nsb8JhL8ZpbqYEEX6qyMW9bKMSsHvhUnw9MqNbJC2aaoC7ImWQFcwfbzX?=
 =?us-ascii?Q?DSDgH8Qe89RArx7CZS+hg2tnNI7bLU1cblUIZW1pVmQJlSsumK3ett81Ppac?=
 =?us-ascii?Q?Hhf84bVTGw17w6R2g+ZRIrFfW6dc1lJTowxYGMuxn1PWZsuCzNzjBNe/QBMK?=
 =?us-ascii?Q?vMBtnP4xjantZJn5BOEPRKdSPTnHqXj9537IpGs3GGIpzUntWx2dU5QYediF?=
 =?us-ascii?Q?XU+ZlkudhUtp/WBS2XDv6bmsgkIVIP1Gvn4/vyiJ6sDaONjH1cVSIYFJjB/x?=
 =?us-ascii?Q?zDplMWJKSvJ8xMowDQyUtNnG5f0MqqiVgm9hiDa0UULTj7DI2+kmQkq0ZGQa?=
 =?us-ascii?Q?TKxgx2SQu+dGJXnrhc2zjVlZBNEc7X89yWe9NLJWwBkcTpYv5TbHka8qoIqe?=
 =?us-ascii?Q?06QUE2WrSRnhiNqnum6MkGhwheuYcZO+uU6Xok70f0YOpOPp5zyBfAwjDNTI?=
 =?us-ascii?Q?F7k9zWvMWK6ZGgw+Ff2VWgGUpntj/uKjoQldCTU/w2OQZsLyXqIXX4gtTUq8?=
 =?us-ascii?Q?yz7kM8k7g4ekmldJ38FtvKS0M458AzCT44Ksy1daE5ghiDcBwRKunM0qlRAJ?=
 =?us-ascii?Q?/eSis6CwRZ/U2hnQXlriPTXjPpIOWEMciqwt/KuEqGz0I9/Nh0H/E3MW0zsK?=
 =?us-ascii?Q?Z5yKzD8hJwlShujTVKtqlozQFoQxGbb8c4E/NUkOhjjiNKWjTu2scU0OtcOO?=
 =?us-ascii?Q?nX92HrWEIrLPbGtCkVhpzaoWw1Dza1x9QrnGD3sU915FRUKb6yyiZurL4KXi?=
 =?us-ascii?Q?rUq6mo8nbrZusydUb0nWYrn+Uwwh8AXYwh7I4kT/4Xgnp52jsg2hu6jIK5OE?=
 =?us-ascii?Q?yxYAI9n2Q5IQlRySe7+c0oHFi0WtzN912ORwEyRo8ehiwidJj5tr3LAWphqi?=
 =?us-ascii?Q?EYHZdxUBqMRUtmxfzkrTMYemK7rS64o5YBkHaYPWtwU9X5cPisXrky4dlyb3?=
 =?us-ascii?Q?6WkmiLtI+Rue4qCA93L8p20IV3ibKdsO4tSksu6BXEAHdJSDwe3U1XNLbSPB?=
 =?us-ascii?Q?wqXjSf1uf0qO/irC8150qlGVFCs7rVWfEFi5pAq2lFdPcqp9/smVtHEaq5+l?=
 =?us-ascii?Q?c0gRqOj4Zo89RXvEHcnu0jb9CMKJsoy8a3kwZhpiZoI95VvH7MJg0GfSQWm4?=
 =?us-ascii?Q?zl6b9y6lI+Q37ZnLdqqby8Ph+9lQ4bI1rnVI9Jxt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c508e9-5e2c-4b37-8bab-08db3edffc65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 01:06:33.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nC1lKFbYPuzHVFFoxOfyvqkeRuJ/6Ky5aWcDTTL7PNmaipxsO20K0vcX02jgWQDsRwsJMWVv1np9bQ2rT9vHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wrote:
>> When page fault is handled under VMA lock protection, all swap page
>> faults are retried with mmap_lock because folio_lock_or_retry
>> implementation has to drop and reacquire mmap_lock if folio could
>> not be immediately locked.
>> Instead of retrying all swapped page faults, retry only when folio
>> locking fails.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> Let's just review what can now be handled under the VMA lock instead of
> the mmap_lock, in case somebody knows better than me that it's not safe.
>
>  - We can call migration_entry_wait().  This will wait for PG_locked to
>    become clear (in migration_entry_wait_on_locked()).  As previously
>    discussed offline, I think this is safe to do while holding the VMA
>    locked.

Do we even need to be holding the VMA locked while in
migration_entry_wait()? My understanding is we're just waiting for
PG_locked to be cleared so we can return with a reasonable chance the
migration entry is gone. If for example it has been unmapped or
protections downgraded we will simply refault.

>  - We can call remove_device_exclusive_entry().  That calls
>    folio_lock_or_retry(), which will fail if it can't get the VMA lock.

Looks ok to me.

>  - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody familiar
>    with Nouveau and amdkfd could comment on how safe this is?

Currently this won't work because drives assume mmap_lock is held during
pgmap->ops->migrate_to_ram(). Primarily this is because
migrate_vma_setup()/migrate_vma_pages() is used to handle the fault and
that asserts mmap_lock is taken in walk_page_range() and also
migrate_vma_insert_page().

So I don't think we can call that case without mmap_lock.

At a glance it seems it should be relatively easy to move to using
lock_vma_under_rcu(). Drivers will need updating as well though because
migrate_vma_setup() is called outside of fault handling paths so drivers
will currently take mmap_lock rather than vma lock when looking up the
vma. See for example nouveau_svmm_bind().

>  - I believe we can't call handle_pte_marker() because we exclude UFFD
>    VMAs earlier.
>  - We can call swap_readpage() if we allocate a new folio.  I haven't
>    traced through all this code to tell if it's OK.
>
> So ... I believe this is all OK, but we're definitely now willing to
> wait for I/O from the swap device while holding the VMA lock when we
> weren't before.  And maybe we should make a bigger deal of it in the
> changelog.
>
> And maybe we shouldn't just be failing the folio_lock_or_retry(),
> maybe we should be waiting for the folio lock with the VMA locked.

