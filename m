Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2D06AD3DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCGBaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCGBaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:30:02 -0500
Received: from DM4PR02CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7194D621;
        Mon,  6 Mar 2023 17:30:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvWkyIgd9FE90Vf0zTZwDxtsjgBNTfyNFs+Q2n9QwiXCe7IF63iNrXt8zsCDOWlAtU5Im/xNPp1X7d2hauS6IBa1Ls9Cuq3U+m2hcQ4aplCX7+J1Hs10APDljJOuhY+NI/Gu4RWeO0k3q6oeQCYiTPAjOI2ItNEUS6vKvHsB1GF9FLHuKDvUJPLILvbcwRvd+P1iEv/kVNBfCsklGGbZBZKVCuja/5pPEWIqGzb5VQa3gLOE6camknRGPkIaJ6KGvnT+T2USxnxLGq6BBs/461j9NwTIhXvvcFrhY7JNc8oLoJ/cwI495fNhcLHAnQ1tfG4ivT/XyxYe4ixyVknDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBK8dbustjfWyLxlyWzQSvHKM8FNDVgZNhlqBA4f0YU=;
 b=LyWOFAjSjO+NciX6mEJHpvidTWcClHuoyEJxUg0FE0fjkc0ILENwP2vIV4NdfoiCb6JjLIldYmrttrKNPPLTr0digyopGo7BeM9thO/FpdvcDpOHwn2sYLJnLJ55v9e6sgbS8Pdu2qjLyZbej043+21OWGXvOOsZ6IjpGPwyIC9FxHlGDe7uYJyaQEqzVZhxbXYjq3brMbSvWTgFTeqXyhpJuB/2yUaC5JTr3V5pFtAgbUWLMxiTJg82dGFK/rRkDe4UKTrmTj/B5VA3knq+5WP7blUQGgaf1iT7Xa38fqbnpW+43BrHoru9/QukjBcjB7FEAlcFwHODvQDv6OH+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBK8dbustjfWyLxlyWzQSvHKM8FNDVgZNhlqBA4f0YU=;
 b=rK9AbwVB8dHmjjZ3z7enJl8smlj94E4A9QHQXaoTtt8PdgsO620nxGka1HWhcKNbZx7kp/ciSHvw98gs2CujvRv/ujEHqMHWbVd4uKCmgbxaHOSoqN6n4kDZgD0NbsRjKUtpalsJGYCZCJ7Ju9ltSrJCNFIFxE7+cw19229WyV8=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6667.namprd05.prod.outlook.com (2603:10b6:5:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 01:29:58 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:29:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len
 arguments
Thread-Topic: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len
 arguments
Thread-Index: AQHZUH4V9u80YHiRfUSB2Rpal/Yol67uhN4AgAACwIA=
Date:   Tue, 7 Mar 2023 01:29:57 +0000
Message-ID: <209840DC-22D3-422E-A035-B7ADCB8E531E@vmware.com>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-5-axelrasmussen@google.com> <ZAaRPCntR94hGBL2@x1n>
In-Reply-To: <ZAaRPCntR94hGBL2@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM6PR05MB6667:EE_
x-ms-office365-filtering-correlation-id: 224da4cf-394e-410b-29c2-08db1eab7672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5RBrKUNTiHq243kkx09pEViAMTSz9/UBpKlfOmYhOEYmdSHW1oGzXY2UZh1d4I+jGpK9PkoKp4rfvROk8F7JXjIR0ytJDQqFWpW3/6V4xce9PVRmL5+GNJ5QzMoNvmxAw+q6rmB/BipQlVhHmU3jVD1GACPARG51WHkz7fiVDM6j9nsoa8v8UKhbKhR4UdwoRTleSibTOVW+LxsRJXig3xjxD/UjxxnboawRkBINIT/0GX1CduItRF0h9VmbQ1ZPPZ1ny/E8B0184bq4swpbZPs3GppG1JfdEWt838PIuGmOKX59s3cP7fU2gSWm8cVkRhcAobL/cF1slQyK1lpWwcJfkTg56Z4ltV5AGeRlI2hAXGAMvosDGlQ0PNQqfFpzjni09YPGsq18H3ajQ3+SeP7vdLKrxKa9DqnhV8y/1syxGYmuVzrr4lCvEsRbq+cFUdfQibQ2N3K/N6QtqnCkpNlisKq7+ubkoIU4YK9fe6uFRmXRn1ZVA87akI3bWGmBSFh7tb18hqZXPJOKQ6Mh8o7FqSpXiEmWSLt9BTL9LukbOY35jwYZSlVo4YLtvO0jzwHAm94oqvMBh5DlauRXJLFnzS9VMPPwXKCsQB//uL3e3MHfOJX6WTUzAH3m/E4rJjDPzmN9dYQEKTiFlsbnAngZQiPqAqWXgUPBE3K+gGdJq2uRVP6n2WbP8Pdf1dhqryxPBVBIjThBWIWi1w8ycmsHnDkBNZdYngKzu6g/x1Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(66899018)(76116006)(6486002)(66556008)(66476007)(66446008)(64756008)(66946007)(478600001)(54906003)(316002)(38070700005)(38100700002)(86362001)(36756003)(33656002)(122000001)(2616005)(26005)(71200400001)(53546011)(8676002)(6916009)(8936002)(41300700001)(5660300002)(7416002)(4326008)(2906002)(6506007)(83380400001)(6512007)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAl9XbqkuPiXObq3jEBJrWXOY6BQFVoV+8c6p85FHramlhqW9HzMTpryexU1?=
 =?us-ascii?Q?FCYMbPptBxsGuMFqtcze87b4Tx30Qq79huQqijmVstHeuiCBq6cX2HStrTuo?=
 =?us-ascii?Q?ASNDjm447sQBmgEoazTBX+zJ3s4/mFVwM4weYbkxQjjePLbec0G7KPFuHAI9?=
 =?us-ascii?Q?gEbJqNYaHAi0jX5nwsYoFEX1gl2yKz/gKIW7KjcXN8Ab6Zp6Suju/zionAyk?=
 =?us-ascii?Q?w12Wr4MT8/nhLWb8REzs7+FmMHl9JBPPn2G78vWq3V0R9d8yITGf1/9SBswG?=
 =?us-ascii?Q?pdPuYHYRBKx5My63tHvDKSwbaArqu6S9M03/2Fyo9SjHsK2PFgC2n5zhbqUh?=
 =?us-ascii?Q?DN5knr+EUk7zienS/+Pkko8jmo8VwNShal7EyBnIP5f6KnAG64RvEmHhysis?=
 =?us-ascii?Q?M9PS1aflRk3Ibihl2b47azm5n1Y1jNccYAH1MVDAtsNJAV7kueMHBNgddSCY?=
 =?us-ascii?Q?T9W2N8M5WKLbNkPVuEiLhKgzC9EWy3lMqo6E7OuHgox4K4IjzxTMSPUCHJNf?=
 =?us-ascii?Q?dofNl2jjKoz3JYqeXIQX2sK20IrJ5KFtNAKGGVIgBICpYS4cheE9jIFi6hOW?=
 =?us-ascii?Q?78wzWU6c6x8mJYH1WU/z35w6VTF9Ch0FiJ9IpURTR90zEO3S43feefw2G4y0?=
 =?us-ascii?Q?6VqtzLzskQx+g/jzs3At2EZo8tk9sQRCqWQhgfeqUt9CDPUlIMnoQOe7g2rZ?=
 =?us-ascii?Q?zYF/IHet1ZOCi99eu/fWZIKJWCslnhMMwvMBjhwZsOTXch+P2p1RNfDSdCd0?=
 =?us-ascii?Q?qmOlmNoiScL2bwxYu39wuoVzSuNpbIVLsdp1VgA/aLXGZB3Ta+ysHlUypEPP?=
 =?us-ascii?Q?NHplOuLCXKUBLA3xdsayJGqSOwVZmeBgt0auR86afJZ0F5GskyB43VnnxG06?=
 =?us-ascii?Q?pKdWNeBMvMHqdG0dtID0myn7kns5TRe/wj//YJtKM127LCflTKPhJTmd+pyz?=
 =?us-ascii?Q?CiuBVZZfn257qE79iYNwvF7TRmGeQOgW/iqYvYpCvWalx6kN83M/C38kICSF?=
 =?us-ascii?Q?7DtFExeZb4YWFO3ppphhkh2WfNyW4eAHL4itQT/sT5tvAoiuBDts+0um/WF5?=
 =?us-ascii?Q?zWFuFNUwP2v/nGtqZqUJhCTRqVHnWmA6UHNr/uyoS1unoCGmPxYJxq/WTFXy?=
 =?us-ascii?Q?bWInDS3rB0X/tyxo86zdIP+JltxkVUT2qAnbuxN1gwJvqG8SKRSt+fmxu+cN?=
 =?us-ascii?Q?jqmRlzsXuJHhMOfKXktCugPDEwwqJivj1dn33ZlAnEzveJL2EIq38RB/S+CF?=
 =?us-ascii?Q?SnJZ21wAd2+MLbHNAuNjjwalwh8P3LqSSrvGVS2nM1oEIHDwvDgAng9uA7Hc?=
 =?us-ascii?Q?/C6gsJxIvO4I75RJkNhO5caSIM7/C/e/yqynwd3257BtLdYV0rEdjSWo/Haf?=
 =?us-ascii?Q?SLUCwt+U8LMoAyJiGMiQA3XHVf6oo/Yu8KGjpBCcU1akDAHVVfKo708e+swc?=
 =?us-ascii?Q?fSMGlbyy0fr13WnF87tZyVXD+Tu8B9EvxBLVZFHXWRYCVdqgHYB/r46ljkb7?=
 =?us-ascii?Q?w4iTeYUyy2/62Iiw2ELKWxLWTMYSnJ+IdIKNuka32E3Vh/zGD+DbNJqAIG+N?=
 =?us-ascii?Q?nLtV5IPAf9ikfBXCVyWQ6+GMqniwzuvB3UHwDa25?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04BC7981C92E304AABDBF36A01B39BCC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224da4cf-394e-410b-29c2-08db1eab7672
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 01:29:57.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHmQBefQpAG+4IQ35WbXzmFFMKdFaCDjXJor1/DFtCug64QrnH01AN2bMvdKggO8MkzUckEwatZE0B4U3B2lGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 6, 2023, at 5:19 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> !! External Email
>=20
> On Mon, Mar 06, 2023 at 02:50:23PM -0800, Axel Rasmussen wrote:
>> We have a lot of functions which take an address + length pair,
>> currently passed as separate arguments. However, in our userspace API we
>> already have struct uffdio_range, which is exactly this pair, and this
>> is what we get from userspace when ioctls are called.
>>=20
>> Instead of splitting the struct up into two separate arguments, just
>> plumb the struct through to the functions which use it (once we get to
>> the mfill_atomic_pte level, we're dealing with single (huge)pages, so we
>> don't need both parts).
>>=20
>> Relatedly, for waking, just re-use this existing structure instead of
>> defining a new "struct uffdio_wake_range".
>>=20
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
>> fs/userfaultfd.c              | 107 +++++++++++++---------------------
>> include/linux/userfaultfd_k.h |  17 +++---
>> mm/userfaultfd.c              |  92 ++++++++++++++---------------
>> 3 files changed, 96 insertions(+), 120 deletions(-)
>>=20
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index b8e328123b71..984b63b0fc75 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -95,11 +95,6 @@ struct userfaultfd_wait_queue {
>>      bool waken;
>> };
>>=20
>> -struct userfaultfd_wake_range {
>> -     unsigned long start;
>> -     unsigned long len;
>> -};
>=20
> Would there still be a difference on e.g. 32 bits systems?
>=20
> [...]
>=20
>> static __always_inline int validate_range(struct mm_struct *mm,
>> -                                       __u64 start, __u64 len)
>> +                                       const struct uffdio_range *range=
)
>> {
>>      __u64 task_size =3D mm->task_size;
>>=20
>> -     if (start & ~PAGE_MASK)
>> +     if (range->start & ~PAGE_MASK)
>>              return -EINVAL;
>> -     if (len & ~PAGE_MASK)
>> +     if (range->len & ~PAGE_MASK)
>>              return -EINVAL;
>> -     if (!len)
>> +     if (!range->len)
>>              return -EINVAL;
>> -     if (start < mmap_min_addr)
>> +     if (range->start < mmap_min_addr)
>>              return -EINVAL;
>> -     if (start >=3D task_size)
>> +     if (range->start >=3D task_size)
>>              return -EINVAL;
>> -     if (len > task_size - start)
>> +     if (range->len > task_size - range->start)
>>              return -EINVAL;
>>      return 0;
>> }
>=20
> Personally I don't like a lot on such a change. :( It avoids one paramete=
r
> being passed over but it can add a lot indirections.
>=20
> Do you strongly suggest this?  Shall we move on without this so to not
> block the last patch (which I assume is the one you're looking for)?

Just in case you missed, it is __always_inline, so I presume that from a
generated code point-of-view it is the same.

Having said that, small assignments to local start, let and range variables
would make the code easier to read and reduce the change-set.

