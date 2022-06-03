Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9253CCEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbiFCQJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiFCQJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:09:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB82CDC2;
        Fri,  3 Jun 2022 09:09:33 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 253EYpTw001493;
        Fri, 3 Jun 2022 09:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XZ+EO7R0eNShnoqklwtent/SdHe3MDO+ixmYWocUJTc=;
 b=UsfWO72APL/96ZfKnN1O/t1cY+YNO07coK+zjrbQRm+eG4eqvDGJSXVzsxbhSq55bAwd
 ixpfnwlVGHmHmLws4Rzvxa2JnhnG1vknKtcaPPd/5g1kq020WSBYejjbFLkEiSGBf6in
 odEa49LqFDPTSPFcD6hYLyvCSMsXEI+pBvY= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gevu50b63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 09:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmwuYL2BaXt8bqfpqjsiFKYWPQtoXCuzPamCo/Bx2/RI5A/4h0JwbdZotr2tmIfmXfmvXAq+Kihi9zK+AbwdM1kD/capmStc+mwCuF3SQkf9GlChKeWlNsSx3BoiGpYTLXMoC5YSk7eE0Kub+uRxUyj7Hl6PZYTIRWliaSabz2sVRrkEmi9KeH5lG4qHLO1kZfJs1pIljn5AJ/LXZ4rIbUFSvKOScwc99ZRiTuuPO2cyk5IHcPD7UxogPNYmyyVi84ScwE5ph7x05ZBahtduAFCiBr3ai/p6A21VpLM9FiFVVecoE3ic2KJ6kMO2PQvv52ZAX1NYE1LeZ1c64Y3Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ+EO7R0eNShnoqklwtent/SdHe3MDO+ixmYWocUJTc=;
 b=nz+F23acYbvTnNzqvRSFoWhQ/yheUqlfRYpttlQKBAOxTjp66+wjyb0Xyqv/uTAkfQqCyafF9TMcTtgg3rr2P3vhrSgZ7V0mfzZiIQ2FQr5oiQ3n+nROiiYeQy+/SEW+HbLUcwIdH4UNiTx7LATIAd+JwF8zcd7ipIXbs026EJiESnA2aZ0jRzXg02M8hc5HXElxABJfeETmm/q0LOR6Trh4j2Zfx/zzTLm9IMBiE2jHdgRxuotHCybbWKE6gUjOBqHcPCD4SeJ9RtDpg3GWFrVuldKJYYH/Xwp1eHGYhvBj6B7YBmO6nzMBPhQi/zcRAbWpXGFPcA3Sq+Li0YgR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH0PR15MB4429.namprd15.prod.outlook.com (2603:10b6:510:81::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 16:09:23 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 16:09:22 +0000
Message-ID: <c3620e1f-91c5-777c-4193-2478c69a033c@fb.com>
Date:   Fri, 3 Jun 2022 12:09:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area> <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <20220602220625.GG1098723@dread.disaster.area>
 <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
 <20220603052047.GJ1098723@dread.disaster.area> <YpojbvB/+wPqHT8y@cmpxchg.org>
From:   Chris Mason <clm@fb.com>
In-Reply-To: <YpojbvB/+wPqHT8y@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::25) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81e1a2d6-ab3a-443d-852e-08da457b6c23
X-MS-TrafficTypeDiagnostic: PH0PR15MB4429:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB442924033F3CB498EA33C014D3A19@PH0PR15MB4429.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BpLcnh/R3TsXZr3KmZagJgTkvgVblEFquis1vOXovEmRYYdrC9tq6+AjnCW3shxbc8StXDuGp1WBvirXKe+CrCOyy1aYF7dKnkDSrXGUgYusb7ViqKyKUK85q82fk/ssfEe0rYRRn2WL7s+/95Aaenu1MvA2hcAGsPj5I+cbzT+hNLnK7jjL/APV1jiw56oDpBWsecbKT/4ey3AghtJq6l3HU/LANdgqoOe2AMFUodt/q926wLynZ7zPLsuimrf6eK6bkcIwZay0mlmYr83C8Qu8HkWODcF4S/Z895AK71h6CTCzZDngKRn9k80pxF65+uvgMHoOjRhlQcl1Grz6cbwboyy+oEugQ7ZBabraUdDwkthDTTundisKtEQFsmRpagtLxCyRnY2RRjLx2ez/uthSSV1Xva52gzxD3V7vfWgKhHt2BrB31jTXGcU09Ucd+0Hcc+UkHS39D9LXOD3xiQ9x8CxnSdcXWqs8CAuTMGiyhPQSPr77ut/p8R/X7u944pNH3/PI+RxOpvZCppNLM/wC+fNXFUqALYgGmWvxqEmROaTYTZnaN68/qRng6jTLqJ6iUUivSnO/VbDWQQLZ81fIm9y4J0oNCl0yMAf6wusGJ78vhZK879FOAx9ZBTiDDf8Tr/Fij+LFobd+Ex7wM8Ov+tKrHZaU5rcSy5bdS8QaBoJ//Tj5YJtki0kSyE/wVociPaSOOWTTiyD0TmlVaQ4KM5vHov/kGka3ca3wCELNBPFUN4Y1Vt+/cmS+76j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(31696002)(36756003)(53546011)(52116002)(2616005)(54906003)(31686004)(316002)(6512007)(110136005)(6666004)(6506007)(86362001)(2906002)(508600001)(5660300002)(66476007)(83380400001)(38100700002)(8936002)(6486002)(66556008)(4326008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlhYRlNnUlIvN21DRlFyYWZsdFBiYzhiZW5hOEhxZ0FLOEh1RUE5R2N3Y3NC?=
 =?utf-8?B?K0JHUVRxVmt5Q2FyNFcxZlUxZmFVeXFFRE1KT2t6VlBnOHFiRmVlcCtLTUdh?=
 =?utf-8?B?ZVRvbFNYOVE2a1pmajFkSExHaWdkOC9wQ25CTzBLNXo0M0tkNVJFSjJKNWl4?=
 =?utf-8?B?dTBRUHU0ZkdEQ1lxR1pMZWZadmtKUHRxUEY4TUVpMjRFcW5Xa0VKSlc4WThJ?=
 =?utf-8?B?S1B1Z3RpOFM2Z0N3dGlnVzFjaGk0a2J3aTlDa0VIM2g5bEJOTmFNYit4Nko0?=
 =?utf-8?B?L2NUSjJxMmRQUk8rR05OcmpmQURoTlBjdm1rY2lQWDZYQlRNditzR0pRd0xz?=
 =?utf-8?B?VlBQa1doMGNQcDFVc2QwVVBuVGNBeFRNL2dRWGNWbVd5dW5EcmRrUHIveTNQ?=
 =?utf-8?B?VGoyRFJHamRDNDdBSWN5MGZmRWxObEFMK0ZEZ3JjY2wrVkJ4MDRjYXFKbzU1?=
 =?utf-8?B?L1dOMnM4U2lvTFk5dWRucUwrQW41Zk42Qzh5ZFFWMXdLYkY2RElLL21MV1hG?=
 =?utf-8?B?TE1hbDFObWQ5U2dVOFA5dE1leWdBbSszUFYwSVEzcFJsblo0VGxiUWVHSjBV?=
 =?utf-8?B?SHFPckZKekNCMTY0MHQ0ZmRPamxtNHNPMGRYSHB6SjBNOVFHcEtUNFJzam1Y?=
 =?utf-8?B?SDlCbUFhYmFtZGRqOFFIbjBCM3FHUkptalZVUVRwNGM5SVYzZ3piQjVoYU5C?=
 =?utf-8?B?UC9uZHVRajBaR08xZ3hKdkFVamgvV3ZmSWdZTVhYZHg2dmxjekYrWEZzRlhS?=
 =?utf-8?B?RktTUzhKbHk2WjAxU2dsMVM5cldwUm1KZzJBY1pPWjRSQmpZVkphZDRoUGpF?=
 =?utf-8?B?ei9RU0tqVnJ2YTFMNW43bHVRTE5ISVBDaWhFb2kzeHRIVENjTEpRL09Uakps?=
 =?utf-8?B?UVVucG5lbG5wTTFYc0JheVZSUjNacCtVTkIwR1pMLzM1OFB4QXdYeC9RMzl1?=
 =?utf-8?B?NzQrMDFsQ1poTVFKNDdLdkdLRkVVazFyRGJ0TnVTUFBteDNobkhMbnA0N09O?=
 =?utf-8?B?L3A3Y0kvSjlxWHdrVlNabDZ4Y0RUajUwOXJoTHFWS1dqN0tNU3ZNdHcxQ2dV?=
 =?utf-8?B?ekVGV2pENHZGaEVTUllRQmRwKzBrZkVYZy9QMDREa05UYWhTcVJMTWdUUitl?=
 =?utf-8?B?L2RwbVdYOG1RVVVaVmhRRjBuQkd6WkQvaitrUk1CRi9QVHFpU3ZYdk03cHdG?=
 =?utf-8?B?MFN4WHM5MWRqdGxUZjBGUVR1RThCcmsxeUFIczFaczg4Z1JWcFJXV3RkQ0sy?=
 =?utf-8?B?aFJ0YVBZS3czUlkzSG9OMEhQOS9XUmpFOUo5VUZqMVljVzdtUDdqMnVIbDZF?=
 =?utf-8?B?aGQ4dVZJZk9mYnBPaDNFWVNXU2pWVFVnMDZGdUZhZmZqMWpaMXNzVUpGd2c0?=
 =?utf-8?B?NklZRk9pLzZqWGpVOWVkcVptT0dNUFdMUjdRTWZtb0hOMWUrM2JhRlhTeDdx?=
 =?utf-8?B?TzkrNGhnRGZBYXNQWG1QL0hMSHgzdlhYajA3cStmSzdWRDNYa2NKS2xMVHdu?=
 =?utf-8?B?a2pTdGx4YVAxT1FhTk1xSXdiK2ozTXVJRUQwbXlVWUFUOFJac3JES3dROWR0?=
 =?utf-8?B?Y0FIbTE3cmdKY0wrZ2haVzN5MU9zcHJyaHFSdDZZU0ZBbEdxUkgrU0tBdk12?=
 =?utf-8?B?SmlQeTMrTDFvaGtqeUtlKzhjeWM1QU9vSWhIRGtGQWFFM2hxM29QMXVMNDZX?=
 =?utf-8?B?QVB4NXJrNzZjNlpQclFnRUJtS3ZOQTFHSXVhL0FPb2VLcmtRQkcwemR3WkNJ?=
 =?utf-8?B?VkpDbXRZZkp2emJLdlFya2p3SGphQUY1US9JbjVZWkZwY3RvMlBaSzhHNWI1?=
 =?utf-8?B?T3lnQ0FYK25wU0l2cTBEcjlvVXlrbm9jdkdydS8yaFhKV3c2VFZtUU45WnRm?=
 =?utf-8?B?TXhKV2NuV3U0K3FhRE9rb3JoTjA3d3dXaUtzd05NSE5uSXpTbUNGNThZc3Qr?=
 =?utf-8?B?UUVWKzJTbEttb1JSN0loN2E0dG1XWldNRzFIUmxLekx0c24wSzVMTDBDejFi?=
 =?utf-8?B?aUdEQlB5OFgzdEFwSEV1SjhOdmx5b3VnOTZiNXVLL0NMbnF1WnM0MzRhaGZm?=
 =?utf-8?B?UWY4T3Buc292RXRtRG8vbjZKeldQMDg1ZHlMNjR2a1Rha2srb3lSbDZCUVNo?=
 =?utf-8?B?c0FkOGhhUUlGckNHZkFRTGJGWEFrdkNpa0ZuMTFMaGZ2Z2o0cnVPR0lrM051?=
 =?utf-8?B?UGVrcHB5eFpIUGFlZy94RVRVMWdrUFpZcEdCWVM5OTd5WEk2WVRLZXY3aEZt?=
 =?utf-8?B?d09SNitRVlFUMGY5bi9jUzMyemhGVXRxK09JQ1NvN0dyVzFhL0wrbDdGNXJs?=
 =?utf-8?B?Qlo0d1V3Z1plMENCZCtZQUNHR2NJN1JDa3B3eHBRaU0wQm1JSmFySllSZW9j?=
 =?utf-8?Q?mOj08eJ/vxVHqIFQ=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e1a2d6-ab3a-443d-852e-08da457b6c23
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 16:09:22.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXsiFAXPFaflTHT/UwK04ooR2tgGcEawrNeVnkCEJJPkchSjCg12uJJwParpIJOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4429
X-Proofpoint-ORIG-GUID: E9hDWoJE0VLj7bDv6wHSC1BDx88XkDqr
X-Proofpoint-GUID: E9hDWoJE0VLj7bDv6wHSC1BDx88XkDqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_05,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ From a different message, Dave asks wtf my email client was doing. 
Thanks Dave, apparently exchange is being exchangey with base64 in 
unpredictable ways.  This was better in my test reply, lets see. ]

On 6/3/22 11:06 AM, Johannes Weiner wrote:
> Hello Dave,
> 
> On Fri, Jun 03, 2022 at 03:20:47PM +1000, Dave Chinner wrote:
>> On Fri, Jun 03, 2022 at 01:29:40AM +0000, Chris Mason wrote:
>>> As you describe above, the loops are definitely coming from higher
>>> in the stack.  wb_writeback() will loop as long as
>>> __writeback_inodes_wb() returns that it’s making progress and
>>> we’re still globally over the bg threshold, so write_cache_pages()
>>> is just being called over and over again.  We’re coming from
>>> wb_check_background_flush(), so:
>>>
>>>                  struct wb_writeback_work work = {
>>>                          .nr_pages       = LONG_MAX,
>>>                          .sync_mode      = WB_SYNC_NONE,
>>>                          .for_background = 1,
>>>                          .range_cyclic   = 1,
>>>                          .reason         = WB_REASON_BACKGROUND,
>>>                  };
>>
>> Sure, but we end up in writeback_sb_inodes() which does this after
>> the __writeback_single_inode()->do_writepages() call that iterates
>> the dirty pages:
>>
>>                 if (need_resched()) {
>>                          /*
>>                           * We're trying to balance between building up a nice
>>                           * long list of IOs to improve our merge rate, and
>>                           * getting those IOs out quickly for anyone throttling
>>                           * in balance_dirty_pages().  cond_resched() doesn't
>>                           * unplug, so get our IOs out the door before we
>>                           * give up the CPU.
>>                           */
>>                          blk_flush_plug(current->plug, false);
>>                          cond_resched();
>>                  }
>>
>> So if there is a pending IO completion on this CPU on a work queue
>> here, we'll reschedule to it because the work queue kworkers are
>> bound to CPUs and they take priority over user threads.
> 
> The flusher thread is also a kworker, though. So it may hit this
> cond_resched(), but it doesn't yield until the timeslice expires.
>

Just to underline this, the long tail latencies aren't softlockups or 
major explosions.  It's just suboptimal enough that different metrics 
and dashboards noticed it.

-chris
