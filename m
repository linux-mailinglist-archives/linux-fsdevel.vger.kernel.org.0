Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB471F488
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 23:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFAVXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFAVXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:23:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405C184;
        Thu,  1 Jun 2023 14:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drwO0Io9qhuQLIZpo+8yx2RUBeuruzR3JGiFZQF3IVYicHoT9zl2IFsJZtITeF6uzS+1KFgsZlGCsircDGQ2BBv3YTsgkDzLLyYX8CHksFRscdAQUwl1o4i5vVVOmYmDSBwOBSsAoaSkpQYXDd4gju7UnNWYKzbi/ILx8p2Dt1EzPpXuyIo0yzqprtvGnsMHirq4LEaLNAluVj9Yu4PVDdlaZKsNR+uRi3qgDlOiIg/1zdD+DuGPpdMPY9Mql1Zm6wsJrIkldZflpzTtE46bw18xNS5SPeRyS6OBoIzRJbHtdr3wx7mhJgZksGL5ceVdHFwViVrcixHOAFEbAp6zVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHm/wLjaXbRtHbLiJPV0mrtBAtky9Eog48Ym5ZYeMUM=;
 b=oFM6koubA0ivdNeRTqIbxYRX49X8GcLtv1MYhU0E0KOhM/EsLrgok5U42mESIX9upkUWyMqCXrSpFuXOMjsao1Br1gJAUpsigO+yWWCekxsEgtzaWm18t547e+TI2CnY6ExaVOumZUwgp2XEowGaZWNroj0AABu7XUiJdQRiuWD3cRTxf+c3h+pLL6a19f0I1MQAUx9VumB0xBVRPKDTPiKcthsmkDiK1j0h+bb3ctltB8y1PBrkDxb/yZIxIRYGF89ON7bzraICaSQ+sWpLn+J8i0dH8pQSj3kAzhwH+RXeQ81L9k5quPg2vMYpILXP1V0Kg4/EGzhNqs+4PhkM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHm/wLjaXbRtHbLiJPV0mrtBAtky9Eog48Ym5ZYeMUM=;
 b=kGvbgibgq2Rj2CBQxjgvrRlhhJIYNG4ajyJaOqOtKSrk8iNnXlTTe/0F7exfd90jeA/ma/+RE+njJnvQVNuuUfsTZ0E6NLSUYL3BPwUNpKw9LSAJZarDhrplikEQz4aJIJjtZ6lfvKsSUEQNa4NNL2Ioni3K9L6beBo4BE4MFhgUeq4/Q6CGyO2lCRYI94X5GQROMoFlBxe9yn+80eZGYaVZ40b36kXrCKR/XB0qBQyGGS60+XoSYhAQ5gfv30dgM9D0IPX8Ub2sEeVAmX9FzsPtDbp20rgfDgbhDtTjzx17uVXpevThkKVRCg9YI9dHWWUhF7Of2eWc2hD7naHp+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9155.eurprd04.prod.outlook.com (2603:10a6:102:22e::15)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 21:23:01 +0000
Received: from PAXPR04MB9155.eurprd04.prod.outlook.com
 ([fe80::5a2a:3622:97b3:8004]) by PAXPR04MB9155.eurprd04.prod.outlook.com
 ([fe80::5a2a:3622:97b3:8004%6]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 21:23:01 +0000
Message-ID: <29fcea18-d720-d5df-0e00-eb448e6bbfcf@suse.com>
Date:   Thu, 1 Jun 2023 17:22:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org
References: <0000000000007bedb605f119ed9f@google.com>
 <00000000000000964605faf87416@google.com>
 <CAHC9VhTZ=Esk+JxgAjch2J44WuLixe-SZMXW2iGHpLdrdMKQ=g@mail.gmail.com>
 <1020d006-c698-aacc-bcc3-92e5b237ef91@huaweicloud.com>
From:   Jeff Mahoney <jeffm@suse.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
In-Reply-To: <1020d006-c698-aacc-bcc3-92e5b237ef91@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:208:23b::7) To PAXPR04MB9155.eurprd04.prod.outlook.com
 (2603:10a6:102:22e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9155:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9d1e18-dd12-435a-39b0-08db62e660d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCQ/TUibiJ4C9DItCEM/+QKMeUPGS+waJNs6oaRCdAErMUAMg+wA+d7EpPH2bDE9ycXrM5kXBiBr0etlYPyDheGNHswdyS+85xUEOJ2F3KJx6JsWEzFZxFB/kldB/DVMh4MhHliRZfr+EzFIEvqN7PHAAXFCUrp1VQ61NXRRLfWDSjBuoNO3tkCJyLdUMJEU9zdVBTg8a4yU01MaB7LMsn/ivbX3O/4E43xmLOEG+ziZxKY0XT+Gvhs+QFEfMWb//gZ9CoQu1Kb/8mLEmTcjoWx51RN7BvT06NXw1/8cUDhmNKfYzGTfi5gUf5cj8mW8n0nAkhYKEKOFMbTUgF9eXwwFRilnb954UGFI27fqkZuQ9E15FheMjjW3JZiFmsNxL2/9AkzrmZK+eNnZXrdSirCDPwAHF7huq95wIBwb8ZDMJsuetAYH6qAvY7NomJMNNUPBrAhDxYlHfnndl5J/oWlJ+ugrmU0n0xjfdgDvtIODECqE3ur0Gl1/NnOqSNXEk7ZgPNSjZyTCdqCtq+EXxOD1TCZ2FFVD+gwzrYA2xW11FNmVmPlgYQ5O4l6t84D78iAnYW6WkDZxyVms5l0L/oyz3qG5nZlF0/oUJvhWm1xYUKdrW4tU9uXgz2E6p1+mZmbjGw0Cehgpsnglec3i2wB3HQJeWVPPilXz85nd8ZDnKxiuAF+xGl+jG17d81YqKKoQ+jDPaZWfFxqUCn/CYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9155.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(6506007)(6512007)(186003)(53546011)(6666004)(966005)(6486002)(2616005)(83380400001)(41300700001)(316002)(2906002)(7416002)(8936002)(5660300002)(8676002)(478600001)(66476007)(66556008)(66946007)(110136005)(86362001)(31696002)(36756003)(4326008)(38100700002)(31686004)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdnZkVIaWdWNHdEOFJBT25QbkFGZjJDOEMrMzdOaUpIaVFSRUtHWk93RUtn?=
 =?utf-8?B?UlJXNFJ1aFdOUTFaeVl0MlAvd01BQUlQMGNxaDhwSkVOSndaMDZwVWg3NUdh?=
 =?utf-8?B?T0R1R3Y5bkc5cEl3akNNcUFPME1WQVM2QjhyWGNUdWZaWk84aUNFMzRkaGdv?=
 =?utf-8?B?UWl5ekxxSEpGdGpPeU5xcFgvbU5GYWQvQkVIMHlMWU91RXJ0VlFudHlaczdo?=
 =?utf-8?B?Vkp4a1Y3aHA1WkdjQkFWVy9NamhkZVZvNWdncWszV2xSZmxRQXBCT3UvQ3F3?=
 =?utf-8?B?bTA5VjRtZlF0QXNCRXQxTEpoVHA0SDRlOUpsclNtbUlnMElaMGduY1Z6VG1w?=
 =?utf-8?B?SHp1L3Q4RFNpUUNUQzgvZlJLU2RJLzVDdFpIMG1NUDNKT3h5ejdPTlJWQm5D?=
 =?utf-8?B?Y1BWNUFWUHdoN0lNVUJyUHVORUhHTmVUaWF4cEl1ODRhWDZlQ0RkNmxUYmpY?=
 =?utf-8?B?VmJ3dHNDUk1kclpMaDdQTXp3Wm1WOVdSQmxqTzJsV3h4UjhhY2lVUDRTUEtt?=
 =?utf-8?B?RTVpN1hQSmpsMUc3SS9TUVhJVVlnSkl5d3drM1M4dzdZei95VyswdytGbnE5?=
 =?utf-8?B?WllaU1VQeDBEMUxNN2pXWTBlb2tNQVgwNDZ1ajJXTDFxMm9RdEIwVWJXK1Er?=
 =?utf-8?B?RGNyL3NYa2VHUE5ndzBHNVR2MksvT3NPUnFIS3NMc2ZBVyt4MGlMcGF6bXdz?=
 =?utf-8?B?ZTc4TGYzblVJV2xnV1YxQTJLZXJNcUxUZUpvZlBNZGlCV2lVQWw0alZPNllT?=
 =?utf-8?B?cFI4ak9OMUVtNlJMSFIyTDNNRWhzZXRDcUFTY3BERjhUQnY2WFNpcUZZY3RB?=
 =?utf-8?B?cTBUeVZueDQ4cjMyZzl0RUtZb1hYUkxhdXoxUnU1L09yYVZ6QVJHeFNKZ1o0?=
 =?utf-8?B?d2IrZjBKNHB1QUVrWXJuUngybllCMUVxVGlPVUtNbDJ5MzFGVW1RVjdhSkVJ?=
 =?utf-8?B?ZS9JcC9UQmpUT0RobkJ1WE00K21TUDl0Z00xUGFHVHlKT0RPRDhsZEptQi9D?=
 =?utf-8?B?Y1BVSXdSL08vM3R4M0FKRllhSzk3U21scTYydWpURlNOSXR4dlRobDc1SmpS?=
 =?utf-8?B?bnVvNlkxL1Vja1NqK3VaamZXMW80OGkrTFhJNDRUU0dETE1mbmtwL2ZvS1l2?=
 =?utf-8?B?L1NlNW9wclJ2V3oycUUwRVp1L3k1SEo4RmZTTllxcGRHd1FvV2NGNThyQjFV?=
 =?utf-8?B?RDVFY2JXRnZjL09hT3dOVVZQMjQxeTk0NzRZUGlQTWpQZDJDZlkxdzVDN3hG?=
 =?utf-8?B?OTg4RlhjQ0dGemErMllzNXhlclgybThibnprb0ZlSHhTcmdaSkJPZ242N2ln?=
 =?utf-8?B?bC9VdE5GRnJtN2RKeHdmRWZIc3dGWW5JazRGUnQ3bnRxQ2NFVkNDUHFvaGh3?=
 =?utf-8?B?b3ROOFFGcW9uVWw4ZnVZMjNrdnZLVE9jaEJyUVgraHVscGlkT2VEekE2cVVa?=
 =?utf-8?B?bHJSczZsNGRhOU1GYkRTNEp4bGFIOTkvUTIxWm1GYm42Uk43U21hL3l4NCtj?=
 =?utf-8?B?c3krK3AvbkVKVGhuZEhEU0J5TW9kY3FzWTZDVXFiY3B4MGU4RU1BTkp0VS9X?=
 =?utf-8?B?QUdXZ0FZQWxkQnJ6SFlTaHFCWUwvdjhZd29ZVzN2L0tlWThjSG1yNUFUVE9n?=
 =?utf-8?B?ak9ieHVtQ0FmbWltQlN5QWhkU0FwRVUzRDNPYmlsYWFBZllFYzVFU2FUV25N?=
 =?utf-8?B?WDJuU0Y2Y3BoV2p3VDhGY1Fka2hpa3AyYUZFdUczMkQ1YXd0bno1WHhnWHVS?=
 =?utf-8?B?T0V1OTlLQ1VsN0s2WHcyeTlML1VXc25tUC81NFVhWSs4WllycWp5czNSTkUr?=
 =?utf-8?B?NVBLa2J4dTNxZEprTnBzNkZEQW9Kc2NwdHVzOTR5VkYwd3hCcyttVDk3V2hO?=
 =?utf-8?B?U1dCRmJMdm5RWVJ6YktZdnBSY3ZZT1dkckFzaXQ4S1dHSXhoOHNKUnBMYWk5?=
 =?utf-8?B?azRUQ0Z0VjNMaTdFdlh3UFNKM3RYUmxLdU1oZmZBZWhGdFRXYXorVjlVam1Q?=
 =?utf-8?B?dnFQR1JUY2tNSU1mZEJtcCtuK0g5ZnV3WUpBejNqYjB1TVZXbTJ4MDRzZzUw?=
 =?utf-8?B?STh3U3RGN3MxK2ZmVitUekpzYWlhZ1N1K1RtZkxETGE1U0pEcjBVWmZ3WlVN?=
 =?utf-8?B?N20vQXZRbzBVSC9oc0daT3V1TzEyUktrRmNUV0dPUVYyeWtYcnpKb01Jbk93?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9d1e18-dd12-435a-39b0-08db62e660d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9155.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 21:23:01.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnXNwl4w9GJeIifbVOBoRPp9Yqigs3uUx6v0xXaBBHC7leYzcDZM39oY1a3T9Ek5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/23 05:49, Roberto Sassu wrote:
> On 5/5/2023 11:36 PM, Paul Moore wrote:
>> On Fri, May 5, 2023 at 4:51 PM syzbot
>> <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com> wrote:
>>>
>>> syzbot has bisected this issue to:
>>>
>>> commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
>>> Author: Roberto Sassu <roberto.sassu@huawei.com>
>>> Date:   Fri Mar 31 12:32:18 2023 +0000
>>>
>>>      reiserfs: Add security prefix to xattr name in 
>>> reiserfs_security_write()
>>>
>>> bisection log:  
>>> https://syzkaller.appspot.com/x/bisect.txt?x=14403182280000
>>> start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of 
>>> https://githu..
>>> git tree:       upstream
>>> final oops:     
>>> https://syzkaller.appspot.com/x/report.txt?x=16403182280000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12403182280000
>>> kernel config:  
>>> https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
>>> dashboard link: 
>>> https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
>>> syz repro:      
>>> https://syzkaller.appspot.com/x/repro.syz?x=12442414280000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176a7318280000
>>>
>>> Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com
>>> Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in 
>>> reiserfs_security_write()")
>>>
>>> For information about bisection process see: 
>>> https://goo.gl/tpsmEJ#bisection
>>
>> I don't think Roberto's patch identified above is the actual root
>> cause of this problem as reiserfs_xattr_set_handle() is called in
>> reiserfs_security_write() both before and after the patch.  However,
>> due to some bad logic in reiserfs_security_write() which Roberto
>> corrected, I'm thinking that it is possible this code is being
>> exercised for the first time and syzbot is starting to trigger a
>> locking issue in the reiserfs code ... ?
> 
> + Jan, Jeff (which basically restructured the lock)
> 
> + Petr, Ingo, Will
> 
> I involve the lockdep experts, to get a bit of help on this.

Yep, looks like that's been broken since it was added in 2009.  Since 
there can't be any users of it, it'd make sense to drop the security 
xattr support from reiserfs entirely.

> First of all, the lockdep warning is trivial to reproduce:
> 
> # dd if=/dev/zero of=reiserfs.img bs=1M count=100
> # losetup -f --show reiserfs.img
> /dev/loop0
> # mkfs.reiserfs /dev/loop0
> # mount /dev/loop0 /mnt/
> # touch file0
> 
> In the testing system, Smack is the major LSM.
> 
> Ok, so the warning here is clear:
> 
> https://syzkaller.appspot.com/x/log.txt?x=12403182280000
> 
> However, I was looking if that can really happen. From this:
> 
> [   77.746561][ T5418] -> #1 (&sbi->lock){+.+.}-{3:3}:
> [   77.753772][ T5418]        lock_acquire+0x23e/0x630
> [   77.758792][ T5418]        __mutex_lock_common+0x1d8/0x2530
> [   77.764504][ T5418]        mutex_lock_nested+0x1b/0x20
> [   77.769868][ T5418]        reiserfs_write_lock+0x70/0xc0
> [   77.775321][ T5418]        reiserfs_mkdir+0x321/0x870
> 
> I see that the lock is taken in reiserfs_write_lock(), while lockdep says:
> 
> [   77.710227][ T5418] but task is already holding lock:
> [   77.717587][ T5418] ffff88807568d090 (&sbi->lock){+.+.}-{3:3}, at: 
> reiserfs_write_lock_nested+0x4a/0xb0
> 
> which is in a different place, I believe here:
> 
> int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
>                               /* Path to the pasted item. */
> [...]
> 
>          depth = reiserfs_write_unlock_nested(sb);
>          dquot_free_space_nodirty(inode, pasted_size);
>          reiserfs_write_lock_nested(sb, depth);
>          return retval;
> }
> 
> This is called by reiserfs_add_entry(), which is called by 
> reiserfs_create() (it is in the lockdep trace). After returning to 
> reiserfs_create(), d_instantiate_new() is called.
> 
> I don't know exactly, I take the part that the lock is held. But if it 
> is held, how d_instantiate_new() can be executed in another task?
> 
> static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
>                          struct dentry *dentry, umode_t mode, bool excl)
> {
> 
> [...]
> 
>          reiserfs_write_lock(dir->i_sb);
> 
>          retval = journal_begin(&th, dir->i_sb, jbegin_count);
> 
> [...]
> 
>          d_instantiate_new(dentry, inode);
>          retval = journal_end(&th);
> 
> out_failed:
>          reiserfs_write_unlock(dir->i_sb);
> 
> If the lock is held, the scenario lockdep describes cannot happen. Any 
> thoughts?

It's important to understand that the reiserfs write lock was added as a 
subsystem-specific replacement for the BKL.  Given that reiserfs was 
dying already back then, it made more sense from a time management 
perspective to emulate that behavior internally rather than use new 
locking when practically nobody cared anymore.

See reiserfs_write_unlock_nested and reiserfs_write_lock_nested paired 
throughout the code.  It drops the lock when it passes a point where 
it's likely to schedule, just like the BKL would have.

Yes, it's a mess.  Just let it die quietly.

-Jeff

-- 
Jeff Mahoney
VP Engineering, Linux Systems

