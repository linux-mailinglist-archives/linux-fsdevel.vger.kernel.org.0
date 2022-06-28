Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D155D24E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243075AbiF1EUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiF1EU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:20:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF03629CAA;
        Mon, 27 Jun 2022 21:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt8Qks7WrvYm3I4WiTD4PFvM14T7XNfr73ZNRgII4cNPijkKOErqqPOhikFP/CL5mcbofJLUlZYuXjOKG5WVbEy5ZeusynZkx2+qTQVPfsnrDYJOd2VWxbYJDhXdJt+khts21V+LWH4Z/g9NG2kmXH7VW3Vaps78nw+/ltw8gCPSdvMJP8i49kjrIBo4e+3l5inGWmKUqDUJtBamhjU87cm5aF6tuz19F2gBTqmDWsq9ZKVM6V7KC9hODcsf+05jhjgKZ1ielcjgT0oEpvvFOZo0Dsjtha0C7WBPn6NFq7eugRf4zwf6AlVhscePzWWd1gu0VBOqdhY+Z1M9gaEWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m+r9yhtgekX8HmGotgPDslPE5ORoyfLDF9hFNavtrs=;
 b=cUQqpyb5F+dsVP/GKGQ8hcKR6wkd/IfloEVwe2jlmLIjRSBVFobMl9muO/7sW2yOQcqocu7V3WdBWfOKL3bwyOE2FbP7T2rtZWsIeJfuZbuNGbj8H73icraxzosa4aUue4EiZNVQF73nQKPbWk3MSeXoSxdoiC82J3QwQS4m4b06lC7WYxfymviu7Znkvsu0UXqFxEdCMJ0Jtg3rlhUgnjp/zh/em7/dwEXJIIaeAwZwMtPrqivlPbi6DCfCsWAl6RbOqKnlR4iPOWd7UoQwb3wN3EKJ0YEimycBJ+RWX3a5dfvDywjiMNgpCSVavUD/kTXMsF0AHOotIAFbYM7u4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m+r9yhtgekX8HmGotgPDslPE5ORoyfLDF9hFNavtrs=;
 b=DujZfhxdakBjUGIaLIo11RDHhxyRCwSO1ny28TKkBj6fWIJY3GRuz84C6erGFopLF2Esu/S/EW5Udg9dhZNUC0a99EKcEg5NaHA0sfSLlIMcl7/Pm7z9mJIfdXIQKqqGDuBgephydL74cZKOAFVodBG5GIBNQiMFxt507f9LLeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by SG2PR06MB3259.apcprd06.prod.outlook.com (2603:1096:4:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 04:20:20 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::9c97:b22a:d5d5:d670]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::9c97:b22a:d5d5:d670%5]) with mapi id 15.20.5373.015; Tue, 28 Jun 2022
 04:20:20 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     zhangjiachen.jaycee@bytedance.com, vgoyal@redhat.com
Cc:     miklos@szeredi.hu, bo.wu@vivo.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: force sync attr when inode is invalidated
Date:   Tue, 28 Jun 2022 12:20:12 +0800
Message-Id: <20220628042012.60675-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAFQAk7gLTYCmX3-4ABkc4Kg-BhO9YvEmZCg8aogkNsEHjkK35g@mail.gmail.com>
References: <CAFQAk7gLTYCmX3-4ABkc4Kg-BhO9YvEmZCg8aogkNsEHjkK35g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29340b11-6a0e-4778-54e1-08da58bd834e
X-MS-TrafficTypeDiagnostic: SG2PR06MB3259:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWQBmDcL6YVZH/O7zfME+lFPT6T78OhThvDwXBRdq+EV6dFgEYlyEREFTypULveFmNQZeXTAoq2AzcERfYwCsKZAgkxn+AJnV99A0rCKqTCYoZchgnnonC0wsQqvp7ux9TM9bUCGKFZh1VvVv1puJIkFdgaXKEoO/T0nZHr1EfKGUngvD8PG2xaahTj/ZuxhsR4Vfiwonb1PVXfS0j4eDPS7JI3TjMkVCzpGFj5yI6K7DGfwRSBPid/vtFMqJhu/TGHcR4eJV/ebwp/oRQ1YRZihxQ2GoDUF4hewtH0BzVW6paJNbYq434urWpiBGnhIkCvXeFOw1cqGrxz8HO7Kx/XP1GHJh3ns6CTkuZ2q74fIOYsS5+13PGfPSBDxmKuUMiqAFUMq3M7NzZJqG5l99dZo6PGVxiS6FVOQybVyvPHfVRiD3oWiCA0cAfN5GL5b80KMilsQkiC1DNZbVfk9YSr2ixZvaZHjgoL4eF2Jhlo9HTQ70FuWy821X8VIBI+XRajYiEN+/L6Hyna1QeiPGlIcLdGgDu9zhU0vrS2mMP49tsOrmyshnk84xh8VWoEcevaA747Jxplc5PeAGIzEYUktZ75IzXi+vcJ8S1cW+x1ABDGVgGs2KMu79rz+G1iFrDWf+ArPQ85PugS/XefQnS4Vloa2lz/epXgmRob1AfnS1fS/VRUTZjcSG3luT+quYw0sSZ2rynP2+E9EsL+ettKi8kxS1V4sXV8E8XWvqiaENwTB6FtLLDFDeBbjRtwp9LULYooQ8ZmvECCa033GXak7a3yZyX3GZyX69yYzogsD3NWIDvz3EQYUJOFIEyl1gXMPhCb3U2nXpPqGZ5+k0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(86362001)(4326008)(478600001)(6506007)(186003)(6512007)(2906002)(26005)(6486002)(8936002)(53546011)(66476007)(2616005)(66946007)(1076003)(52116002)(41300700001)(66556008)(966005)(316002)(83380400001)(5660300002)(38350700002)(38100700002)(8676002)(36756003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGEr6RIB6DeZCgwbAZe8xEyaVZKqRFN29VM9juBuF5T80GLzwl8yFK8ediKI?=
 =?us-ascii?Q?iHXNtiVyhfrTOvk990BuYAVRYMCdu3GxD9NKGsQ31hrf0793pi3zrEbiWd1y?=
 =?us-ascii?Q?WLEyPMLnatOEugfWC0b4jqNw/OCI0y13SgWLzPlvZKZIxRPsJGJ6iEL2fhDB?=
 =?us-ascii?Q?PBPAAdntuxq+veYgyw2G69FszhC+P83dQZXUNR1uAzu7HUhq0GwL9NlDF7Lv?=
 =?us-ascii?Q?xToPCd7JmWWyqPYFkqyvFRSq4z3TSuX+lv2QK2xzcGbnKlDB7wEZSewSaDsq?=
 =?us-ascii?Q?xL1g9wdnvwhHqw+KVCkoHKL+U0Qx3WUoRIwqO1QVf++T1IBrjfEgLxxzaB6B?=
 =?us-ascii?Q?ILJPGERN6SrkFcyFxeGkxBDIIdGJTqF262TaSjesmE/7LCoRJU0Vtx2FQV3/?=
 =?us-ascii?Q?O2cltBydKDOR3HgJxzKHOL+Lx3db5CMOdbnkKV85GaDno/S4iSsZsUYDhJm5?=
 =?us-ascii?Q?7irjqVk4AXTJUaYpKUdLP20/hPNTtOR1+vvJbyl2N2ZUAtnkxYVvn730bzcy?=
 =?us-ascii?Q?OVZ/UMAZUyAqROW8XDh+P++L7hYyg4/xVRfmxGljhiX4YJCqc8GXH9+xB6lV?=
 =?us-ascii?Q?X88TPTTBAoF2k61kuBqBehb5of1+0jyctvE6nrA1w9NfhUi97fdVIkhK2ZGt?=
 =?us-ascii?Q?SlRtLg/LzE9/qNhi/MyRzE07Lc6YV5PtxCkN8EnjNsNsE7WGSgEqmV3M4JqB?=
 =?us-ascii?Q?JTBiF1IDJOSJQTAcmWNi8Z8GY+sJBtCWYmOeZACqoaxcd2NIwAv3tNRxExHB?=
 =?us-ascii?Q?Wq/4qkZgY+CK15mzuud2H3JKMNtVFJtxR+o8XQUUcBdzneTH/eOR2dGmlBHn?=
 =?us-ascii?Q?w1sUVs7XxVzIKEqpzc838GaQ9jbvKQFF326Sem2KzyODG7dWEPkIUazSdWCo?=
 =?us-ascii?Q?Rwa33RolJjPyRPNFoToB9tnaPBdDn1HixDlSsWFwnX4f2FFGklJ5ZCbPKev/?=
 =?us-ascii?Q?gmrlm40aL6Evk0QEbGwcnr6elFPLw6/FVImCDMFu2/1nfNhgAfOEaRl6GCp6?=
 =?us-ascii?Q?fxVkP188o37i1MVptWgekeAF3AGb3s7q3Nsh3Ht9QOWGXsAXkLMJ9OoehwPP?=
 =?us-ascii?Q?cL748S1iadralmb95XwK7bPmN+XNyoMpNtMUrepUrQ4z/qD6BEj7tIlNpCLb?=
 =?us-ascii?Q?+VGXX/3FR3FTn6Rz4p6nz09tkX3IRao0miDUYFekOAnws2fIP00ZtUWR8RDZ?=
 =?us-ascii?Q?5C04Ls0Nw6eQtJK+WE1lTH+HZN56pRgUDVO2LcTrfaEgbnJGBjZEZGwrfF/c?=
 =?us-ascii?Q?DUfoqP55NUHpIUPcQclNyZ1wz7jwGU4e7sDP88+VLfdGvFqT4Ff7ei4moqMK?=
 =?us-ascii?Q?xUQOA7d+o2UaEDvllhzGYfr3NgGzYPvMSEh3fIZ8+EXGgxC9Nrk9SKGOL00x?=
 =?us-ascii?Q?6SH3E1IXH5S/qBBrdE+yZNvIFGROFRbU3xQXjGPPpFbRIkDl/L2ywgQt0tL+?=
 =?us-ascii?Q?K1x/ndb0ddifhZlk082ciOILQBeRaq9LB8Vvuwys0x7qyvFDjh/N9ugdP39S?=
 =?us-ascii?Q?TJKcerA7vn3ICFVIIewzUQh3HEW3LsE/z4vdeWdQd7+ZDYK3/qEiSIRHp/7+?=
 =?us-ascii?Q?AfdgpOzZqAgiSCfNJK34adwKymjHFoh8Wg4t4dl6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29340b11-6a0e-4778-54e1-08da58bd834e
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 04:20:20.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irwgyfvZktG47U4QWI668zUyH1GxDtPH8vbRHD+uglA0POI/tZ4/v7EeLYKHlkXtGQejkXQDwWlBybpTAZ1lgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3259
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek and Jiachen,

Sorry for late reply. It took time to build open email infrastructure in office.

> On Fri, Jun 24, 2022 at 10:27 AM Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
>>
>> On Fri, Jun 24, 2022 at 3:26 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>
>>> On Tue, Jun 21, 2022 at 08:56:51PM +0800, wubo wrote:
>>>> From: Wu Bo <bo.wu@vivo.com>
>>>>
>>>> Now the fuse driver only trust it's local inode size when
>>>> writeback_cache is enabled. Even the userspace server tell the driver
>>>> the inode cache is invalidated, the size attrabute will not update. And
>>>> will keep it's out-of-date size till the inode cache is dropped. This is
>>>> not reasonable.
>>>
>>> BTW, can you give more details about what's the use case. With
>>> writeback_cache, writes can be cached in fuse and not sent to
>>> file server immediately. And I think that's why fuse trusts
>>> local i_size.
>>>

Let me introduce this use case. It's widely used in Android11 now.
Android11 use fuse for APP to access the public files in order to support the
dynamic permission. To increase the performance at the same time, Android11
allow APPs to write big size files(e.g. jpg or mp4) directly to the lower fs
bypass fuse. So this issue come out:

       APP-a                              APP-b
  Write a jpg file through lowfs
                                     Read the jpg file, size is 1M
  Fish write
  Update the size 2M in DB
  Invalidate the fuse entry
                                     Size keep to be 1M

             [ Drop the inode cache manually ]

	                             Size be update to 2M

If the inode cache keep in kernel, the size will not update forever because of
the writeback mode.

>>> With writeback_cache enabled, I don't think file should be modified
>>> externally (outside the fuse client).
>>>
>>> So what's that use case where file size cached in fuse is out of
>>> date. You probably should not use writeback_cache if you are
>>> modifying files outside the fuse client.

As we all know enable writeback mode can improve the performance. So this
feature can't be disabled in Android. And the key cause of this issue is that
writeback mode in fuse is not so reasonable now. And there are many methods to
fix this issue.

>>>
>>> Having said that I am not sure why FUSE_NOTIFY_INVAL_INODE was added to
>>> begin with. If files are not supposed to be modifed outside the fuse
>>> client, why are we dropping acls and invalidating attrs. If intent is
>>> just to drop page cache, then it should have been just that nothing
>>> else.
>>>

I proposal force attr invalidation. Because I think if user call the
FUSE_NOTIFY_INVAL_INODE as Android11 do it, they definately know what they are
doing. And the fuse driver should do the expected response.

>>> So up to some extent, FUSE_NOTIFY_INVAL_INODE is somewhat confusing. Would
>>> have been good if there was some documentation for it.
>>>
>>> Thanks
>>> Vivek
>>>
>>
>> Hi Wu and Vivek,
>>
>> Recently, we have had some discussions about the writeback_cache
>> revalidation on the mailing list [1][2]. Miklos gave his initial
>> patchset about writeback_cache v2, which supports c/mtime and size
>> updates [1]. However, those methods do not make use of reverse
>> messages, as virtio-fs does not support reverse notification yet. I'm
>> going to send out a new version of that patch based on the discussion
>> and with more considerations.
>
> The new patch:
> https://lore.kernel.org/linux-fsdevel/20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com/
>
> Thanks,
> Jiachen
>
>>
>> I also agree that, semantically, FUSE_NOTIFY_INVAL_INODE should
>> invalidate i_size as well. So I think this patch is a good supplement
>> for FUSE_NOTIFY_INVAL_INODE. But we need to be more careful as the
>> size can be updated from server to kernel, and from kernel to server.
>> I will leave some comments about such issues in the following code.
>>
>> For the use case, writeback_cache is superb over write-through mode in
>> write-intensive scenarios, but its consistency among multiple clients
>> is too bad (almost no consistency). I think it's good to give a little
>> more consistency to writeback_cache.
>>
>> [1] https://lore.kernel.org/linux-fsdevel/20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com/
>> [2] https://lore.kernel.org/linux-fsdevel/20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com/

This is a good solution to this issue. But I think we don't need another
writeback_cache mode, it's time to do the cache consistency under
writeback_cache mode.

>>
>>>>
>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>> ---
>>>>  fs/fuse/inode.c | 10 +++++++++-
>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>>> index 8c0665c5dff8..a4e62c7f2b83 100644
>>>> --- a/fs/fuse/inode.c
>>>> +++ b/fs/fuse/inode.c
>>>> @@ -162,6 +162,11 @@ static ino_t fuse_squash_ino(u64 ino64)
>>>>       return ino;
>>>>  }
>>>>
>>>> +static bool fuse_force_sync(struct fuse_inode *fi)
>>>> +{
>>>> +     return fi->i_time == 0;
>>>> +}
>>>> +
>>>>  void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>>>>                                  u64 attr_valid, u32 cache_mask)
>>>>  {
>>>> @@ -222,8 +227,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>>>>  u32 fuse_get_cache_mask(struct inode *inode)
>>>>  {
>>>>       struct fuse_conn *fc = get_fuse_conn(inode);
>>>> +     struct fuse_inode *fi = get_fuse_inode(inode);
>>>> +     bool is_force_sync = fuse_force_sync(fi);
>>>>
>>>> -     if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
>>>> +     if (!fc->writeback_cache || !S_ISREG(inode->i_mode) || is_force_sync)
>>>>               return 0;
>>>>
>>>>       return STATX_MTIME | STATX_CTIME | STATX_SIZE;
>>>> @@ -437,6 +444,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>>>>       fi = get_fuse_inode(inode);
>>>>       spin_lock(&fi->lock);
>>>>       fi->attr_version = atomic64_inc_return(&fc->attr_version);
>>>> +     fi->i_time = 0;
>>>>       spin_unlock(&fi->lock);
>>
>> Seems fuse_reverse_inval_inode() only drops page cache from offset to
>> offset+len, should we only invalidate i_time on a full cache drop?
>> Otherwise, as the server size is stale, the users may see a file is
>> truncated.
>>
>> Also, what if a FUSE_GETATTR request gets the attr_version after
>> fuse_reverse_inval_inode() increases it, but tries to update i_size
>> after the invalidate_inode_pages2_range() in
>> fuse_reverse_inval_inode()? In this case, server_size can be updated
>> by invalidate_inode_pages2_range(), and FUSE_GETATTR might gets a
>> stale server_size. Meanwhile, as FUSE_GETATTR has got the newest
>> attr_version, the kernel_size will still be updated. This can cause
>> false truncation even for a single FUSE client. So we may need to do
>> more about the attr_version in writeback mode.
>>
>> Thanks,
>> Jiachen
>>
>>>>
>>>>       fuse_invalidate_attr(inode);
>>>> --
>>>> 2.35.1
>>>>
>>>
>
