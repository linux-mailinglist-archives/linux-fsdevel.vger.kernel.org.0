Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2C67A1B87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjIOJ73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjIOJ70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:59:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1452735;
        Fri, 15 Sep 2023 02:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ejscp8uoqWNOjjlDCWKO/f/vSluMyeIgagXwBl+gX216vVoaAbOq/1M6npRaoJjgxlXr98yUozlLoJ8czovD8SSM0aZgCA9B5v2MZoKHFlHhhCtZQ1KOCgKq5wnSYUO2lYYEwzJAKFvWixDZa0CAjKHM+XhJFaUvk7PQp8u7dD28wexwpxIs7vPv5ArAbAXkkxf+gWo61Ih6eNOyb/IIB+y7A5U4jMmphIRqY41GHpnpOCXtFQxcjF/2tWBmqnIu13FcY5IgGg5QVnRMPf2ey9vSkXSXtv1+BjkDqHM0d3wNFE41eb0JcDSa2qc7VC75F4Br3THKMrMbf7lk/cgUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NtG5w46J+qin33suvuWDWldx40kzXTtiF1HgsDTBb4=;
 b=dal4ytknSKH2hq8xzV0mUxB5uJM58lStRSOkdElz0IEQYmFZtghajl2dxmWeA2N4fnudQsdMdspUlALdrvj6nREQ9T/by6Vl22NvhGU8rMtktEwhoPPdI/VCdg8RHiOQ7/wPvfUsl3mFTjEKaNWxSfETe7pV6azGJuBfjoxnaftwgkVRIvs8NXrpJ0fChE7OzbdiHWFUXZAdSrfFIfMCDRmL8mZoeRrujR+hrBpX04WiwKC2ZTrGWZrE3RalnUJoGaXCbWil2a1CcxAAYTMheA+4lCjnNAz051Kadlr4uN+8hES31QQt9o2/O2ZT3xshIAvwcAafTjWSWNaLYeIbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NtG5w46J+qin33suvuWDWldx40kzXTtiF1HgsDTBb4=;
 b=ABuoqxjgfy7hh4rehTeMAbNvZm82tvnNgN+zzfBeIeELqMGbHwL0wdRKzjQq05KNektuOvw8ww9bvH+3P+MsrxlCaRDhSckZCbP1jO019lGJ+/8HMC+WOlRbDJ7+STuNZaB0j6VTX+yBcYGbtxb3SvpxBPrT2ZGYU1RBc9jyK9Q4VMynz8eXuxtINIIb/wY9f3uS+2r1diY6kyOasKM/iJMfsaxSMcalaxUQ2KWqKTfR+xGkirk6hDqmgV1gYVBs5hQrben4ooo8OXgb2UEPM6BinUxGeROqmVLWR1mvpjcrEmdxyECIpCVJA8IQTAbjYoDHzYViA/qEjtXLN2KLNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB5872.apcprd06.prod.outlook.com (2603:1096:400:334::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 09:57:13 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 09:57:13 +0000
Message-ID: <315b565c-2f1c-4c51-a645-a5c3a4e1e3cc@vivo.com>
Date:   Fri, 15 Sep 2023 17:57:09 +0800
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBmcy13cml0ZWJhY2s6IHdyaXRlYmFj?=
 =?UTF-8?Q?k=5Fsb=5Finodes=3A_Do_not_increase_=27total=5Fwrote=27_when_nothi?=
 =?UTF-8?Q?ng_is_written?=
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     "chao@kernel.org" <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230913131501.478516-1-guochunhai@vivo.com>
 <20230913151651.gzmyjvqwan3euhwi@quack3>
 <TY2PR06MB3342ED6EB614563BCC4FD23FBEF7A@TY2PR06MB3342.apcprd06.prod.outlook.com>
 <20230914065853.qmvkymchyamx43k5@quack3>
From:   Chunhai Guo <guochunhai@vivo.com>
In-Reply-To: <20230914065853.qmvkymchyamx43k5@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYZPR06MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e6bca4-cd62-437e-6b0c-08dbb5d222aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 202SROzeftiiAtOTLNXZZpmD9I4CmX4ua07WPeRGYMxJ9ehi2pkKTGmXDWMtvofBBFfcvUotM56TVv0ySe9ti/Bzfd1DpOd/3adNB7MU61NXgiKgcu0kJVey92HRoUGnEZcV2TGQU1evc0td2pbNtmWpuebiyAsPFtVqva4gOxiwF/gcxh1tN0jf4WW5Xw6xLa5DW6W1n33GCjCF8J+Jx8yezkKRNlS3lC9Oxv0ZZZYl4FV88TkAgDxdA56gBRVomGjw6yo+1BDT/wRqnwzGl7B9Q/N5KA8fI+hrh6VuCyIRcUwk1cZRaOL3P3Y4iyKE3P/RLhdOpQ5hdu2JAN9XJQLmyRz+ymDg44C4ymYMDs6IzlDbSZz4UPJrdluWiU0C5TH6TLCRUC215SkLfViLKMiiMxar8LNEypwu1CBkwDRuwRZG0Wfc08kELgUzvRhb8r3a+0pWx5i5YPJg7Au8n40Mjhhy4OrZ9SWLIUAUXnuV9XXpnxBBHSenACMzcv8lcNlJZJ2X0VALtkxWmF8omqO7tNmuCLEypDOWV1Fpmf1D4FkEcrbOaWme+wPOhsIghNjWuDDxeFCsC7ntduBhJzTgNmDXicr2p16UAsNVHWZ1EOTzLc9WyxJ4YKRDMKV+tvYJPp6h/UbDWnW6iTFqvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39850400004)(346002)(136003)(451199024)(1800799009)(186009)(66476007)(66946007)(478600001)(6486002)(54906003)(6506007)(6916009)(6666004)(66556008)(41300700001)(6512007)(316002)(31686004)(8936002)(5660300002)(4326008)(86362001)(36756003)(31696002)(2616005)(26005)(2906002)(38100700002)(224303003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R241Y3FLRWtFUmVYU0tHbWYzK3Avc2VzRENObEJrV0c0aHJMbHIyNXJLRkxt?=
 =?utf-8?B?allwd0xYb2ZZbkRIUDI1bkxZN1lTNnJJVTZrYkZUcmtnSjFiejlaTXNjVWFV?=
 =?utf-8?B?RStkZW9RY2s3UFR5bjhjYXA0TlRaZjRJRjY3YkxQSjk0ZTFiY1lSMlE1MzBI?=
 =?utf-8?B?bytnUFB4LytUeGVpM1BGUzJZRDl2emJHK2FoWUFZN2U0VUYxcVBMQkxFenVH?=
 =?utf-8?B?TVpVdGgrNlpXVlM5SmtBczNyeU5kcTNoMkFjYkRwOWJDZzhMRkdNZUJ5dEVt?=
 =?utf-8?B?OWlaUklkWDhoTG01VytQNk5kdXZmbHd6RmlwZUFQelBYU1liU2tKM0s1aEdp?=
 =?utf-8?B?YUNXcmhCd0s2a0RaTXM4aEliWXhBZldQOWIzcXNCZ0xGOGhZeTRkdm1kSG5o?=
 =?utf-8?B?ZlVKVmJHd2hjelExTkRIWkI0L0RFc0s1Y0hqSjdOZnBkYkhrQTVocTBNT2cv?=
 =?utf-8?B?b3dnZ0pVNnFhRWxFTFUyQXE1RHBJRkZ2RGhEdk5CR2JGMXp3SW1iVmt1bTBv?=
 =?utf-8?B?b2NZUW9sNUo3aFhuaTRKV3NSMzhUYkU2dHZMOW0zOGZzQU5UUjY4WGRBNXRw?=
 =?utf-8?B?OEc1MDllOGdLQ2ZYTDArME9KMnBqN0JhTzRFd1FxQnBjZTBOdVJuekw2UTR5?=
 =?utf-8?B?MVBNVHI0U2lCd0tHQi93TDhQRjFieFF2azdaY1lTejR3dFNibnBZOThOazhz?=
 =?utf-8?B?VERiZjVjM2J4YzV1WGExcDJwQnRaU1JzTkdNdVd2dU10RHk3WHFCNWQ0Vk1E?=
 =?utf-8?B?eFd4VmxWbkYzM3JJUGZLWjI3dnlDdWkvdkd4OWQzc0U2YUNhU2dPRUp5Yk94?=
 =?utf-8?B?MkQ2eHBobkJlKy9MYVl4UnBMVmFDOTFraFN2aFlBUTdIUnprV0YweVZxaHh4?=
 =?utf-8?B?WDZvb1Z3eDhVdktOZnJoZldPNUl6aGN4THltS1BsanR1MUJYaThvZnRQOUhE?=
 =?utf-8?B?STZ6aTFoeEFmNDVnODl2RFlzY2Zya3JtNDh4RTJVZThFSTlFSVpvNUUzTUJy?=
 =?utf-8?B?QUtpNitEbVFEWVJFbWlVRHRhQ2ZuSjNIWkhqSHIrNmtOOFZNNGlkZ05xZXZP?=
 =?utf-8?B?KzdVQ2tKbnRoVmEveUMzK1ZkK21wT0piTU9ocVQzQ1lnd2RpY3Q0c2JER3Uv?=
 =?utf-8?B?U1ByUVpqazRVcmNGZmlKQyt5cS9CK3FNWHVaVU9JSWk0QUhXdHJzb08yQ0F1?=
 =?utf-8?B?azg0VUo0a0VZdElLSythMXV5MFErME1yT3BhQ2dLek9RNjZkdEdoZFBwRWhy?=
 =?utf-8?B?L25JcHdPeFE4dCtNNFJRejRjNlJLcXcrRUFVcjh2bTVzdURCU0dmMzE5aG15?=
 =?utf-8?B?YmhueDRmWVRXZTlHVlFlZ1Z4d05yWFQzb1lWK3BIZ2RSS1RzRHJyV0IydHEy?=
 =?utf-8?B?UTJOM25rdzFlZzlEVk0yMjBQNWVnZWlMSmpzMkh3eWdFYk9STy9YZGhFY25i?=
 =?utf-8?B?N3VJZFdzVVFIdDA1OHZvMUpuakw3em5wWHdQVUJWMm9TdGlTNng4Y2ZlTnp3?=
 =?utf-8?B?NFovL041V213OGk4QzN3MUx2TzM1QkoxbDM4R3lPZjNTdndobExnSXZmY2d1?=
 =?utf-8?B?ZHRFNElqbzl4WUM0cCszM3ZadVEyU0MveWttd1ZldjVEbEd6ekkzZHNMVGV2?=
 =?utf-8?B?NVI4TkxDTFVIay9wR0FlSm54MmJ6bnZ2emJGNDB4YjNOU3J4MEVCNGt2VkFP?=
 =?utf-8?B?eWpmaXFCUFNNRzFvL0FyT1VhT05pYWZhNkJ6RUJqNHV4cGQ1SzhoTyt4L3Fm?=
 =?utf-8?B?ZDBPOHFKT00zVnFabG5MTzhKQUMyWk85aW8vdTVuMjVWVGJzMHRlVnZrY2or?=
 =?utf-8?B?WCtTNnB0ZHlyN2FyR1QxMUJ1NlM1bm4zZVNKNEc1aTVIWGJ4SWpZVTV2TlRv?=
 =?utf-8?B?UEwyRUw1VTNNWHJHYWtTbWliR1R5WnN2TDFSMEc4cXNIRmRjejJ5S3l3ZDNq?=
 =?utf-8?B?bWY2aVpEZm5qSVFiNEZWaENPdDZCejRJRkRPamN1ZUluclFkbVluVERmMU52?=
 =?utf-8?B?cjVtNVNrOFNWQkF6dXN5cndmb1V3RkZ3YUpTMi9PL2FSaHlCR3cycWZuOEdX?=
 =?utf-8?B?Z3l0akxqcStUa3IwK1lyMTBkNEZxTGFNeUZ4YjFqb25ZTEdaeUpvQ2dyU0xE?=
 =?utf-8?Q?AaRNpZ5nXKPnd6bL8rnlcucmG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e6bca4-cd62-437e-6b0c-08dbb5d222aa
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 09:57:13.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4OVvhqHtk4Q8q5+qaA+Y1HZtiG9VMJtfQff753QKvEBpYUT+uh0TPwr5XMbCwcYJB6lcIHyIjCDejDGzUn4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/9/14 14:58, Jan Kara 写道:
> On Thu 14-09-23 04:12:31, 郭纯海 wrote:
>>> On Wed 13-09-23 07:15:01, Chunhai Guo wrote:
>>>>  From the dump info, there are only two pages as shown below. One is
>>>> updated and another is under writeback. Maybe f2fs counts the
>>>> writeback page as a dirty one, so get_dirty_pages() got one. As you
>>>> said, maybe this is unreasonable.
>>>>
>>>> Jaegeuk & Chao, what do you think of this?
>>>>
>>>>
>>>> crash_32> files -p 0xE5A44678
>>>>   INODE    NRPAGES
>>>> e5a44678        2
>>>>
>>>>    PAGE    PHYSICAL   MAPPING    INDEX CNT FLAGS
>>>> e8d0e338  641de000  e5a44810         0  5 a095
>>> locked,waiters,uptodate,lru,private,writeback
>>>> e8ad59a0  54528000  e5a44810         1  2 2036
>>> referenced,uptodate,lru,active,private
>>>
>>> Indeed, incrementing pages_skipped when there's no dirty page is a bit odd.
>>> That being said we could also harden requeue_inode() - in particular we could do
>>> there:
>>>
>>>          if (wbc->pages_skipped) {
>>>                  /*
>>>                   * Writeback is not making progress due to locked buffers.
>>>                   * Skip this inode for now. Although having skipped pages
>>>                   * is odd for clean inodes, it can happen for some
>>>                   * filesystems so handle that gracefully.
>>>                   */
>>>                  if (inode->i_state & I_DIRTY_ALL)
>>>                          redirty_tail_locked(inode, wb);
>>>                  else
>>>                          inode_cgwb_move_to_attached(inode, wb);
>>>          }
>>>
>>> Does this fix your problem as well?
>>>
>>>                                                                  Honza
>>
>> Thank you for your reply. Did you forget the 'return' statement? Since I encountered this issue on the 4.19 kernel and there is not inode_cgwb_move_to_attached() yet, I replaced it with inode_io_list_del_locked(). So, below is the test patch I am applying. Please have a check. By the way, the test will take some time. I will provide feedback when it is finished. Thanks.
> 
> Yeah, I forgot about the return.

Hi Jan,
The test is finished and this patch can fix this issue, too.
Thanks,
> 
>> 	if (wbc->pages_skipped) {
>> 		/*
>> 		 * writeback is not making progress due to locked
>> 		 * buffers. Skip this inode for now.
>> 		 */
>> -		redirty_tail_locked(inode, wb);
>> +		if (inode->i_state & I_DIRTY_ALL)
>> +			redirty_tail_locked(inode, wb);
>> +		else
>> +			inode_io_list_del_locked(inode, wb);
>>   		return;
>>   	}
> 
> Looks good. Thanks for testing!
> 
> 								Honza
