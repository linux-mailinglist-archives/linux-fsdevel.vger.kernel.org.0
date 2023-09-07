Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789D9797496
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjIGPkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbjIGPfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD21BC7;
        Thu,  7 Sep 2023 08:34:31 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 387E4nPu028204;
        Thu, 7 Sep 2023 07:29:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=66brWm8vsT2xti/gCj0nsPvANoYcoNKWz3SSp99o9Js=;
 b=MGda45LGq5BjaeGCUq42M0o73YY+jXFqvKeB2dLi3C12i/sWm/Cc2pzU0Rw55RP90iDt
 eEHlX5XxG5Vb+BKlAQcZnETFCOP/LbgyuhRMC7nhWoZyL2bVsNc8wpRvMQ2MBNf8WVqo
 UlrXowmDmAU3OhDSuL1lcFaHhVW9u5+44TUhDebmYkTK4K6vvPqeIvq5JmVE5iVEbcaB
 ANnBHpyqDwUoJ8LqlmFvmCN+WpuNWShqTmjg1z9LzTBz43O4bDGqQUP1dlvcAii9aOTX
 dNkTb8eH5eWP9xZ9fxf6aAeYyKQkmoNUHweKUV2UWxXoXh37U0luPOjCivzyjVKBIuOc OQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by m0001303.ppops.net (PPS) with ESMTPS id 3sy62h4wm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 07:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRi6eBlQ95Dm5lDD7FrB8uv21CldbQRRSHVitEZHl9mx7K8ycezTTKcL9sW2OPd8ruFT5IaY3qwzeGVX9C99MKsxzxNChbEP/3d66Us04Nb2bACht2yzGzqJw5KJO1xZLbW9cyTLrzCDY0a/PFFiMghTqncbZW73t3q4S30XEQs2VKhYNTyy0btiX5e0LRfuimp+YeK360XZWkXEmiSiyUAhMMxGOff/PJTjb/vzaA9ugxZdBpVfUUI4jppacLyaMt6tH4624K/UZHW5QiD94/de6DJMT8S544aQ2VliQt2KWzgGKBhQtnZgaR77q0CHrS+sbsKl+ra7vGkH8CN8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66brWm8vsT2xti/gCj0nsPvANoYcoNKWz3SSp99o9Js=;
 b=YgoK08pjaFUj3s4fyXurIj5ccQ5xNZvnKDo4o9PuFSBwvwypXl/zfSAYHOhDGEmoU77JAYMbm5FVQH4HGDl/QkSOTpJr1KrLAq/1i6weKmWjvguKZ4PvXd+RnxnKNYGIqbsIpqbTIFQN4YHGNw0FtNSdzNACJQvt/UdPfJN4fkTIBdGldOLi4dXGtnOE1aQZNLzFSdvqYQAQ0CER7rl8s/GJF4kyOGq4c54qHaGaXWobFMyx+PYUg0IQzYBDceVn2rKpOgAFiiauGRC+uz0YeU+8CgWoaYcSGbCBjppLHXYnje7itSgy666eTQJBpqZRBCAYrPfRkhE2CP2NvpJONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by IA1PR15MB5535.namprd15.prod.outlook.com (2603:10b6:208:418::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 14:29:48 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::ee15:4e9e:105b:b27a]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::ee15:4e9e:105b:b27a%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 14:29:48 +0000
Message-ID: <2aeebe7c-c769-a258-a2b7-c96816f97dbe@meta.com>
Date:   Thu, 7 Sep 2023 10:29:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <20230906222847.GA230622@dev-arch.thelio-3990X>
 <202309061658.59013483F@keescook>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <202309061658.59013483F@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:208:178::41) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|IA1PR15MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d64d95-acc0-49c9-871b-08dbafaee3b7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wShZH0ryXQYval86+Vkqm+GM31S5BMnljFbSBHDW0KKHmRdVCVs7t5bWO1XEpOi9STpzMUaOPcuzB6YsqNIkdothErsj43rTO0UbDhZCQpYluq5fEYNLjPXNcorK3ZwjfsogCLaJdBOb+HZ+7kLeXXF4b0R8M99Adw+yCtd5GhjK1GW+ncQEQVeOBRBTd3oZ3albqUhBu+cgILWtf6qmFF1Zax5PP9Y/XsAJCAxa3+ExMzRiynXDCseuq1EvKXkCTnu6ncK2zsH4mHRbK9pEzmPFFyTJkoTMmIMW+hOUYt8GmO8PppD3Z8yPM/z+D2ggSMtazrR6zmHjQCorcPg5uVTqATU2QVWvOCIeW9HqqmFwIKndH1Z26HY8T3TCHUM8LL/lx/n6q2v2g4SWBkjqxt1UN5J7FsL+uyvYf7Fu6RDNnsocTKkxTzmyIVxnF46Tmw+midOiJvJiRDuABurLqzbtax+PWlAXtx/Lg/UCTpjArOFQSdlMUreZuJ+UTHk0M0e2cfxyjjOIoFWLBMCiNIPVrJs+Wrof1AM+0Z0DA2NcB8GgEj2rTsFHWRzGtNixOf8h7h7g9iU4hlIXaqoUY2BRQ5Qo5LmQu4q+FaHQi8PGdXastAS+HeSh9deIcJIlfrgj2qRei9Fr1ndIKvCO+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(41300700001)(6506007)(31696002)(478600001)(6666004)(86362001)(38100700002)(2616005)(83380400001)(53546011)(6512007)(6486002)(66476007)(110136005)(316002)(66946007)(66556008)(2906002)(36756003)(8936002)(5660300002)(31686004)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEl1QWc1Q3N3K0xMNlBqQUVqbEZPWjRrWFJ5L1hwN2FsWEVWSG9qTGtzNzJt?=
 =?utf-8?B?MDZlTWQ4eGtKSkdBOUVzYTdWV3E2K013ajBEZFkyWXM2ekFNc2d2Z1ZFSE01?=
 =?utf-8?B?UmpNVWxXZkFmVlhBdS8zR25uZzQ5ZDBaOWE0WlFHc3kzWUJoNGIvT2NxRjVO?=
 =?utf-8?B?Yk0wZFhZdklScGh3U05DeGZIa0ROVnJ4TzdJU25wZ1pJajN3MGZBakZXMzhl?=
 =?utf-8?B?clBVWnZzTGJtMGVCMmlPV2xDblV5dk43TW9FdW1RVmFHL1M2ZXB4VWFEMGFQ?=
 =?utf-8?B?M29MNTRhSys3cnVab3J1T01jUExvL1B2M1BMUVhGY0RMeUFjOXh0cTEySnl3?=
 =?utf-8?B?dDBNSEJ1LzlGeDR5ZzRhanpqWjlVa0VSUEgrQTFMRlB6SS8xRU5odUFKRThQ?=
 =?utf-8?B?MWNBR3dHQndmeGI2NExJc0xSTks5OEhzSURMZ2czLzluMWJWS21jZGw2OEFx?=
 =?utf-8?B?aEtwek1lSzRIeEZhRjBSRkFPc1RCR2NpOVIrc3ltai9oeE5URGpVanZwK2FP?=
 =?utf-8?B?dG1HUWwrWDlLNVduaFd6VWJqQmxKUVBON29SM3hXbFhNZ0RLd00xYXVxV1pM?=
 =?utf-8?B?cE5ZZWNEREE5WG5DS3h0MlBmRmI4R0daQll1UnZsQjJuaVc2VmN2UTZNdHNv?=
 =?utf-8?B?djJESi9iRERHOUdFV2h5SlMzdUdwVDdvN0EyVmlzR0ljbit5RlcrSzZSMFlP?=
 =?utf-8?B?Tk5VeEdleTdZZEJrZmhHK2ZSSjhzN3g4YUlzNUpNZ0ZyelEycmNWbng1UDd3?=
 =?utf-8?B?amIrV1VuUDErTGdweUpXdUdyWGthRzc5U042MVpacmVGS2I3L1BSZXQzWExZ?=
 =?utf-8?B?ZGdlekFHQW5TY0l2UzlIMndRMThHUG51ektnMW5LNXRHYlo1SE1qQkUzcHk2?=
 =?utf-8?B?ZHdnNWdEOGhwUDVrSXQwY0tFUEZLVWFqYUVoT1V1Uk9zWUUwNkdjK0gvcDNt?=
 =?utf-8?B?SjA4SGZTMUJ6UGw2VWJxbUVsdjRLU2RNWmF2aDhIdml2NFo4NXdzYTNqQ29E?=
 =?utf-8?B?UU8vVHlXNy9HL3BLd2s3RElqUGNXN1cxc2s3a2Erc1RIUWpmKzAvY21LRWtm?=
 =?utf-8?B?UlJ2Y0x4UXcvTDROcTExZExUc0g2b2ZDaGdmUlo3ODBLVEo4NzBVZENkOTV4?=
 =?utf-8?B?bkJHSHd2aWhXYWw1VitiQ01ML3FHWTJET0NkajlOMk4zc0NOZHc0T2pjcWgv?=
 =?utf-8?B?ckVIYlBPZU9wTERFdzNDSUxRd0I5WG00elB4bEZJNmtUMUZXM1pvTVpEK0JB?=
 =?utf-8?B?WUFqaDY1MnNWSVdyZWhYZW9YcGVpL3VjOWpURUJBclgydW5aV0RIVWRwajRT?=
 =?utf-8?B?TEFkalpTenBVMVEwNEdJN0J2N3Bka1k5T0JtYjZTdkhRZ2haMHA2ZDdTZE5T?=
 =?utf-8?B?a0dORTZpQ3d3ZXBkbVVtTG0yc3VqNmdlNEpCSlpRNit1MHhGWWxnNUc4cm1k?=
 =?utf-8?B?UVpONDdoWVVkZ1MvWHp0bmhFTFNhb3UyYVFIU3pLb2lzZGpPMktMTGJJWFpx?=
 =?utf-8?B?M21ocXk0d3A1NnJuV1k1Ky9CVk83TjlqMTBMSm0zSVZGV2ZSNlBZcWZnKzUv?=
 =?utf-8?B?UkJjSFc1UFcyd0M3ZkV0MUQ2aWlITkJ4T0wvQnMrN3QyL1VGSmZaZDMxTFVH?=
 =?utf-8?B?djhVMDgzb2NkTnc1WlRzaGlwaHVWaTVpS2RVUVQrQVJlRW1EblV4d3M4Y0hh?=
 =?utf-8?B?UUZqVTc0VXE5d0g1OC93eXhTa2d4cDFvSWlzelRzbElCbncwL1g3ZmdUQkd0?=
 =?utf-8?B?TkVVNXBuYVJhRWpTT0FpVGprTFFuNm5BWFhudElmblBjbktkQ2RXRjk1R2E2?=
 =?utf-8?B?T1pPZkRHMWdzSkQ0cTdHdU9LZXI5aHNiTWY1bm5FQTdyakRJT0tiZWJHL01n?=
 =?utf-8?B?L01jVGRlSmVIZWw2c2dDTVBweGtRWDZwR3pZY0tlNUcvQVZyR3ROdzN6TlJ6?=
 =?utf-8?B?bDZpQWoweXp0bjJvRUdhYVVzQ3RYaUI0MGd5aCszZ0pFak8vMG5VN2I0K29L?=
 =?utf-8?B?VHZFNzBnakZHZndzYmxxOWd6c3VtVkUzNnE0VVFzZytiUnQ4NklFOFcxVzYr?=
 =?utf-8?B?aG5iT1N0R0x3eTZMSWRZbGMxNW85Yy9vR3Exa1Q3MVRpZWtzZHZmeDI3SWNL?=
 =?utf-8?B?azRDUUhLUk1ick5uNTFUT1AydDRBcVh4UklQU1ZBVmZkRHA3TzhaUURreHRW?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d64d95-acc0-49c9-871b-08dbafaee3b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:29:48.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry+/LWGXtNP4z4IIF943KLfVAGaePj9kewSMvrWPkh8iNKXIdpfK+7KkV5P10tXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5535
X-Proofpoint-ORIG-GUID: 6tuUd3mu48I8FDqbFhg9KyGQ8JZlb7UC
X-Proofpoint-GUID: 6tuUd3mu48I8FDqbFhg9KyGQ8JZlb7UC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 8:03 PM, Kees Cook wrote:
> On Wed, Sep 06, 2023 at 03:28:47PM -0700, Nathan Chancellor wrote:
>> Hi Kent,
>>
>> On Sat, Sep 02, 2023 at 11:25:55PM -0400, Kent Overstreet wrote:
>>> here's the bcachefs pull request, for 6.6. Hopefully everything
>>> outstanding from the previous PR thread has been resolved; the block
>>> layer prereqs are in now via Jens's tree and the dcache helper has a
>>> reviewed-by from Christain.
>>
>> I pulled this into mainline locally and did an LLVM build, which found
>> an immediate issue. It appears the bcachefs codes uses zero length
> 
> It looks like this series hasn't been in -next at all? That seems like a
> pretty important step.
> 
> Also, when I look at the PR, it seems to be a branch history going
> back _years_. For this kind of a feature, I'd expect a short series of
> "here's the code" in incremental additions (e.g. look at the x86 shstk
> series), not the development history from it being out of tree -- this
> could easily lead to ugly bisection problems, etc.

When we merged btrfs, Linus helped redo all of the btrfs out of tree
commits on top of kernel git.  I can't remember at this point if it was
his idea or mine, but git history is obviously improved by remembering
my sparse file joy:

commit 3a686375629da5d2e2ad019265b66ef113c87455
Author: Chris Mason <chris.mason@oracle.com>
Date:   Thu May 24 13:35:57 2007 -0400

    Btrfs: sparse files!

I'd have a preference for keeping the old history, warts and all, but
wanted to give a data point to help jog people's memory around problems
it might have caused.

-chris
