Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3B60B1F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiJXQlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJXQks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:40:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4018D475;
        Mon, 24 Oct 2022 08:27:59 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29OFQ0WS000774;
        Mon, 24 Oct 2022 08:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jzA6pzCZ9q1NsPAlxHCY2lQRNO2B9vX5NRZQxUzCZys=;
 b=lpBAEtgeN97oRaHc6ufCFc6N6HnHm1kD2TLxi6zZ+zHZ91omBi03RrphnPHFDhaXGU/j
 dq+9W15Q402FeNLnqHaFdsDd4X5VbWxG4SaEHm9GTU1RszzeqDw0eoBO3oTVom9xdkXW
 fKfIvWfdDQkVi8KPC1NfCefoXoBVuc4TXEWaUqQ1gYpXSQTS1Uc9nAjhIxiSHMZyCY5d
 jbqWqgeyqEup5S8emSi8BHQqWMnvh2M6G0L8jgo66CEZIyESjLEED8AEoBm2NFeWlgGt
 IG7pK1Wu44SuUpMqXxwWexRijWyK7R9jtnZksyiwp8jvQwcHLVlHWVX3NaoFQdXnTwL2 aQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kcc1bjqey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 08:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/8tQIZVKeFkilmPyT6AX82X1DE3HpwODvKMRfLpcV76TPASi9bRq3qFLyZ6JEjGehnE2mb356GnszTouGgen9aAjmx9OzknyVJr82yJuLaHXLuik4YVRudATRTE3b09m6xeagK+SviWBpZXDBfWZgIe8YosJ5VIJHYLUCEV7eTYSIcJa+nTYpARRcdBd7lGRH8WlYs6e3jwKsh0gXMWp4gyixd9IK1B+Dj9mc5FJpmxP0cVRCi+/pag/JzS+nSOifoPMLKxZ7r+jf656Q6s74Ot1xeJDs/0HMtMa1Ouua+xqMv6M5NRZJrcGpBwJ/6R2IflkjTu3qT3yFnFNmuoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzA6pzCZ9q1NsPAlxHCY2lQRNO2B9vX5NRZQxUzCZys=;
 b=DarwTX2rK5JTf8N8fH0fZyhL5JUZaVH3bHfExY8hRPL+q0sE3geAQ+NJyUubyBfT/MY5NELwE1/HQVy8HPRNSvaxaNtK4HXpOcUrUCQcHifgrZp0btzgdrgcjiLyiNL+a4DXoiGJk5e3I9/++QYZt6zyZDmilzZK+6x+eGW0PEvYSppAFzuQF7BVvZC58FY1e9ufNWrFQyMOFVjb6Yp6bYv9bdtWbCcgoXUeJCnIE5KaiIVAQAAGWbBIH0N4EbYC7KV3XAcXwy5haFw2vs2KpOk4Q2CCjujWA5ZCG9P4J9rVY1oHFmYtA7od6gnHbarFKmWufTx5sGc4KGSq1Hvj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by SJ0PR15MB5180.namprd15.prod.outlook.com (2603:10b6:a03:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 15:25:10 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553%6]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 15:25:10 +0000
Message-ID: <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
Date:   Mon, 24 Oct 2022 11:25:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
To:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221024144411.GA25172@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SA9PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:806:a7::27) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|SJ0PR15MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 5555eadf-a9bb-40a9-9f47-08dab5d3f021
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsM6Ni600SFUn/+aIcK4bsHm5ODvzBhYnt2PKDZEOSZGdiilpJE2G/tz6vDF7SoLAa+cOcbbvRqnt2gwJSUwlXLptQns9dijzgCibcUxYNoaiaggJHN1btZHKAmoIfMRQnOPD+PQYkVPmqBCRlwSyLplNTqoq3sFVeky/LmqiYkpy1GKWSvt/Dxrp42d+4x6ZdMabJXOqHFtkUZRb/VAeGjkyxdOzcGov3gJyPBt88VWgHGrwbMYltXa2KkZe7L6yC7GvzCpTTewPO24+iNxrWrzoeQoRgJyOzIFA61/E2hCQObf43gjLJnhYi/mbja8SR4cnLPWHlrxVnF85985/anzYZkmdQTyH1RrmLYT1zIFtSfsxw65yarkrcMI8svUWW6vSsBOr/iekBXjR1ho+MHxQeDKhX5JYoa4SyWA+Ttn6WdQMZXyGHmZ1B7vJrxZcHhYVURdnkZ95eJChZi3t6aK2ZCYj87YCIENeUuEim08Z8JVk2muvTsyV3MckdOJUyJxAujWvo9IT4PItxDwi73PyeLS08JnskI3EdvhSwlAIbEXAerod1UCXPAmxl1DP0p1Qwmj4r/fhQGeID/gZLVvgUEmqmXlDjCIjMPj9LeWJDBwnLydREjRNqUgvAWyj6+G0lI/kEjzuKjJe4WXJZAtl0sLr/0BMTMOFzPB/yoK4IQJwlRkrp2T370Tn13rZU+8eiTz7FOMPkfFmyETYckgARrQPknahpASOxhfRZvgEnhdhheUuOjv7WSZ6Dy0K3szTn5lGxnMTWK5078ukcZQ9sRSG/ppwe34D69C6ytgwFVeZ6gj4g70n0/WnH3+nmXDsTNFJ6vGDD9xNWqT2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(478600001)(86362001)(31696002)(31686004)(966005)(6486002)(83380400001)(66556008)(66476007)(54906003)(53546011)(8676002)(110136005)(6666004)(4326008)(36756003)(6506007)(66946007)(8936002)(7416002)(41300700001)(6512007)(5660300002)(38100700002)(4744005)(2616005)(186003)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkh5MldaYkVZMzNmUHhhdU5sSmdYa0ZUYVJkNkZVMHJqeFZKKzV0NUZ5Wjk3?=
 =?utf-8?B?ay9zK1FxcEhSTnNIVktmSWFncUJjRmpwVXR4SGEzZFNOM1RmVzZuWVRTLzYr?=
 =?utf-8?B?b2VDcEh3TnNZc2FjYlFKOTA4ZlYwR0dXbEYvSFRHWDFzLzZNRFFacFpUMGZi?=
 =?utf-8?B?Yk5lZzlQeHEwTEpzNlNZSkI2M1JEcnhLcGZibnpvY0h2ODJnd0ttenRPQUFK?=
 =?utf-8?B?Q2hXbVZ3K0Y1WWZpZEI4UTk0VlZ0cDNtcFArUTIyNlNUaXc3Y2JLdy83bHdT?=
 =?utf-8?B?QlhaY3djcVNTNEhkZ0hSclNGSHE0cjkvN1M0VXY2NnRGbHFGOFdicDNFdlZN?=
 =?utf-8?B?ekE2bkplL3ZSVEMwUGlpQ0hwVW5CRVBLcENweElaT2NXMHlBRmNtWjQzN2sx?=
 =?utf-8?B?M2kveEs2MTlZUFZRNE9DOGpRSVByVE54NHlCREc3WXA1SjlXMnNZSHJSWkgr?=
 =?utf-8?B?Q3hQMEduRDFERllITjhxeUtMNjZESVZPNGJpZVJIMWFjN0ludk8ySmhHYmw5?=
 =?utf-8?B?L0hnNjF3dk9yRFZlU081Nk4wQnVmTEloaGJFRGY0UFh4eXl4OXEzRTVPRDNJ?=
 =?utf-8?B?S1FzNFhBcGZVb2tkOWM3TWVLQzBkc1Z6SnBqMEpqM05KUDU2RHlIZnpqN0RX?=
 =?utf-8?B?ZUdjVk9iNkwzc3FZTndRL0tkQnJRWnRUK1NkQzlnc3p4MjFDVEtrOEQ1MUJy?=
 =?utf-8?B?dVVtODFQYW4ySm14Y1ZuR2F6RHd2OGdab3lERVlKbEF1SVB2cTB0WU51RnFW?=
 =?utf-8?B?aE1XOXZNRmsvSEZuMnNCdm5KdW1CMk9YTTE2REhORUo1RGg2cDRQYjR4VU1w?=
 =?utf-8?B?WlBsUXYyTmtWTk5kMUVFTXFiWVF3V2tMc2FiQS9jcm4wSUVYM25MU1dncXZq?=
 =?utf-8?B?V0ZZdkZwWFo5QUUyZ2ZLc1pCa2hNazJNdXlFMDBJbnYvYnNYdmR2bDF3OXJF?=
 =?utf-8?B?SVVjT0J1QnE3ZWF6a2pMQnNkMFFmZ01PNFdBZlhCSmpwOW91TFRLNHo4YzRr?=
 =?utf-8?B?Q0ZrdDBuZm5GajloMjYxL2NkZUx3TFMvTUNUSXJTeFRvYTQvUnIyYm1vNDRK?=
 =?utf-8?B?U1FKaE0vWmorOHg4R2ZTNzlKLzRnM2RXYmVxVUd4TTlCN3hSSUxUUkF4RzhY?=
 =?utf-8?B?c0RCR21XTE5LV0NKMjRJMVhZZk1Rb2VPQmN1UWdFSXV5RGJsR0NXeEtWTzdk?=
 =?utf-8?B?dkwzdjZjcVVRN2phWThnYTJuQzBIRUl3UG9qWXRRaEw2MThQVzQzU1VEVzBY?=
 =?utf-8?B?T09zdHNIZ25OaXk1VFRHaWVIblBuRlUzeWhpSzJ3b2dOdXRTU3VFa3FMVjRv?=
 =?utf-8?B?WXZ0Q0k1UjFBNHBxaGZ3S2VDTzhSKzFtTzNzSk1lbEQwa3FDaUd3MXhJZGxh?=
 =?utf-8?B?dXNGUHhweU5ROXl2bU03WURoQWdaeVV5bWZBSWc1NlMyS25JZzhJV0RBNktR?=
 =?utf-8?B?SVkvaWtKZWk3TGpzVVZQWWVOMlR3R2NTRnhMRmQ2NnBlV3ZpVFNITjh4aFow?=
 =?utf-8?B?bWZtMXdHd1RjQW8xZnZlRHAwTEtia2d6UUJZaTN3WjRzQ0RWT1Y3eXhPa2xo?=
 =?utf-8?B?cVJrWnZXdnEwcVV5MmpwZ090WFE2SWRHMGl4UEtmcGRwbFlBYnREM3BrVmp6?=
 =?utf-8?B?RlljOEh5WWxnS2pLQkJzaStaK3kweFNVNXF6aWxCZURSQjR0OEk4UktFNXlp?=
 =?utf-8?B?V3o5YXdvQ3ZRMldkVzMzMDhrRkNmR1pabUgxNlZ5Tm5HS0FNeE93clM5b0R1?=
 =?utf-8?B?aERvSCs5UngydzBtQXBQUG1lRkNVS2VKdkpqUHlkV3FMTVVXZEJjaW9jZlMw?=
 =?utf-8?B?aHJEQ3ZINUNRbmFlWUsyMXQ4UE1ES1luZWVXdUtQdFJONTRNQTRXVjRYSHhS?=
 =?utf-8?B?WkdkdjdNUk9TRE1RRXBXUXFVNG0yUlluWkxrTUNCdWN4bklZRVNkWnltelNx?=
 =?utf-8?B?NGVLeWJETTBIVjZITjZORTFZS2FPbG1CejR1UzB1eTh4UmtUMXU0QWg3WTZR?=
 =?utf-8?B?ZENBWGR4MFpEeHRKeS9BRmticjNOZzkvNlJ6dFNPTTUxRWNQc0oyN0VBY2x2?=
 =?utf-8?B?TDhPK2FMVFVyY1JUOFlJdmpRZTJKdXRYaXVmaXZMTnN4RDRNRXZOTGZKQmhX?=
 =?utf-8?B?Zllvc2JQeEpyLzBDUWg5azMraUJOTWQ3S0tlaU5ZeCtQUGoxOTkwVnBTb3dx?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5555eadf-a9bb-40a9-9f47-08dab5d3f021
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 15:25:10.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/TADz6u0mbPy9OZiNNWpsYKW6GECrf8Xh0nwG78l9PGQS+WgyrL0WBoxYs3R9XV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5180
X-Proofpoint-GUID: ci56iWB2m8TfHLvEAruAXB7YCRHSzTAR
X-Proofpoint-ORIG-GUID: ci56iWB2m8TfHLvEAruAXB7YCRHSzTAR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/24/22 10:44 AM, Christoph Hellwig wrote:
> On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:
>> David, what's your plan to progress with this series?
> 
> FYI, I object to merging any of my code into btrfs without a proper
> copyright notice, and I also need to find some time to remove my
> previous significant changes given that the btrfs maintainer
> refuses to take the proper and legally required copyright notice.
> 
> So don't waste any of your time on this.

Christoph's request is well within the norms for the kernel, given that 
he's making substantial changes to these files.  I talked this over with 
GregKH, who pointed me at:

https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-software-projects

Even if we'd taken up some of the other policies suggested by this doc, 
I'd still defer to preferences of developers who have made significant 
changes.

-chris

