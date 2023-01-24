Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3D67A2AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjAXT2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjAXT2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:28:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2703945F65;
        Tue, 24 Jan 2023 11:28:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoNQ1TK2GDjk/D/06xsUI/nG6r5OigQfwu/SzyHXxAlw1fHqMvqq/UVS77oprcbQMzdp3F5by49iBKPs0QpWP9+Pbt2iK95gziNl+o0aQ5jsTNmzNTeuxMpuAaAkZ1L3MXZoqIhklLgAJ49v8b4dTiPXo3k+UWBfBCRXKi9Cfy+UWxhUWYpXIFx37cF1dRvS84dJvq8a19NJBhaTq8sLoTDjH4WwG2g1PtMKX0EkLdHg+PGWvRJHD0TW7ddb3aJovWAvtrthHvS10g+LmXqCQCT36vYdHhWcB4JzBFklecWtaEK/Tsq+oLWS5O2OubJUo++nCcX/bLMawLD4HAaIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdbzPjSOKgf7mZZ32s51VqhHi9KnjucsuS8IMKFPygo=;
 b=LnTu2BcA81ujG4xZmKNKt8lIoOyMGL8DJnRmoPKycHowooBOpuo4tCfj7Bv0gU0oRlmcnNghzmOuGlqmXFfyvIpmyrPM5hgmjqfpgHaeL5733Iyagc3ODlitFbkjWc53bvcomjpDjf8hzgaN5hqeHnRCZsQZ+i3K75T9srA3rcBaFbzISAemgEaL8aDX77M8m1QR0xs9Bl/A6nFjnuhPTELGAwR7f22PAvgL8QSkCwiBUKRjRPntHQiDaT3clPEzXl2G+i2RkTH46fNcTnfeEfXKLTPtarh0VFhqBhN1O3sm14qR71i1XmqWmGeSI8PilFi+HNYuZzPJcXkmUOGC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdbzPjSOKgf7mZZ32s51VqhHi9KnjucsuS8IMKFPygo=;
 b=cx9AgpuMePnqtGBpBw3H6LLad9PuzQ83fGc5gC0JTWkc5sAMblXJ7b2wggzX+61DIN+u2gzfRXF7342xOOJKK5DBNceI1jeAu3Mdh5b/UHjgH00KG5OHNUlZxbxgcCBcd185aOaIQPLanxpgrbZql+2/fus/dt3byf+B1sdsIQ375HXdOc/BEBKu2PHn/brPXUQRfGbmev7vC7HmQi0xh6POnVlONW09WHUZRC1NrCbU/y9TJjeiWCBG5jFyn8PTgM7YTtF30Ue/DgyvnmXeow/86ia7D/qUR3F+gmjR1hO6DTehjbfeKg2msvVs63DIFdsULycHtnpKtRXrrU3Cgg==
Received: from MW4PR03CA0120.namprd03.prod.outlook.com (2603:10b6:303:b7::35)
 by BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 19:28:37 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::40) by MW4PR03CA0120.outlook.office365.com
 (2603:10b6:303:b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 19:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 19:28:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:28:26 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:28:25 -0800
Message-ID: <ad671496-2461-0b25-48c8-bf474fffe41d@nvidia.com>
Date:   Tue, 24 Jan 2023 11:28:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 4/8] block: Fix bio_flagged() so that gcc can better
 optimise it
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-5-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-5-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|BN9PR12MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 9244c820-1dc5-453f-dd5f-08dafe4130ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmhIDRaIOi+D43rBNiyFzPww+x3FJyRwtpn9Ech2f1/jl+ZKtjIkmXJP9zIF6ZxcFjwZjrSLPuSFZ66CV5SJWA1bfIbWzLM7p+jCMNR9Lmf0GV6RkrhnnFqYr/+D6UDWgnP6YBQHiECQXJ7DA0b6HWqb3d57Dg6itEbjcKbz+NgJJ1kxaeEuBFDh2tivLquPkfADYbVT1wj3Xmeglup0DM+/L0LnDNYKA+vUGW7VeIZAWPODz5XnvPOoXfbA7puMkBl23IfDqqVMHTkytP8H4eu3rxp2VDXbTLCkBgdjObNLtfa/kGLNrNqTtkOLMLM/eYgwmK4kcO3dmEYUhrDppA3i70S8s0ngeU6/KZ3qi4RiWU4JUEipxPDBekmGEYr0lytWCMJ4nI6f4YegbYoayRYRdfFMR60mybW0X5EGU5Xy5OHIr2csIImRZyfOCZW+389VkE9vDr0sToKAMFztFQhSyTgB8NGvtuSB9ettQNww6ZQDje29rcRCBcQ+Z2+UG2yVgZt3VHXJE/CV9/R78DGZPWNGIFTz/ue10ynmG6ThFB+qYoBIrafxREw7OXe5svuPUzMoiUbxPyqhQKrLOXCGB/Wp5AVHeBisTDXt25rIBp/Vw2otAEVNgqHpuHSQQuHSwb/sTWL3ll3aXe7hXE5HRlyFszK9aTVWUgTz8VZl1Zhb6GNvPptfBc9ejV+Fi4pL8IdPuDOTnH6oN4oEx7r/YJ0DHzdN27ozEKY1u+mamoAoIOmVrXGhmPsN6ACcntP8izWmDHq4BXICFgCmaSM7GdbFZeeuDIcMDYTIT3uWIHHeROiSd1Q/6sDejkqI
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(7636003)(70586007)(82740400003)(40480700001)(40460700003)(36756003)(356005)(31696002)(966005)(110136005)(16576012)(478600001)(336012)(83380400001)(316002)(70206006)(8676002)(4326008)(2616005)(426003)(47076005)(54906003)(31686004)(2906002)(53546011)(86362001)(8936002)(36860700001)(186003)(41300700001)(26005)(5660300002)(7416002)(16526019)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 19:28:36.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9244c820-1dc5-453f-dd5f-08dafe4130ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 09:01, David Howells wrote:
> Fix bio_flagged() so that multiple instances of it, such as:
> 
> 	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
> 	    bio_flagged(bio, BIO_PAGE_PINNED))
> 
> can be combined by the gcc optimiser into a single test in assembly
> (arguably, this is a compiler optimisation issue[1]).
> 
> The missed optimisation stems from bio_flagged() comparing the result of
> the bitwise-AND to zero.  This results in an out-of-line bio_release_page()
> being compiled to something like:
> 
>     <+0>:     mov    0x14(%rdi),%eax
>     <+3>:     test   $0x1,%al
>     <+5>:     jne    0xffffffff816dac53 <bio_release_pages+11>
>     <+7>:     test   $0x2,%al
>     <+9>:     je     0xffffffff816dac5c <bio_release_pages+20>
>     <+11>:    movzbl %sil,%esi
>     <+15>:    jmp    0xffffffff816daba1 <__bio_release_pages>
>     <+20>:    jmp    0xffffffff81d0b800 <__x86_return_thunk>
> 
> However, the test is superfluous as the return type is bool.  Removing it
> results in:
> 
>     <+0>:     testb  $0x3,0x14(%rdi)
>     <+4>:     je     0xffffffff816e4af4 <bio_release_pages+15>
>     <+6>:     movzbl %sil,%esi
>     <+10>:    jmp    0xffffffff816dab7c <__bio_release_pages>
>     <+15>:    jmp    0xffffffff81d0b7c0 <__x86_return_thunk>
> 
> instead.
> 
> Also, the MOVZBL instruction looks unnecessary[2] - I think it's just
> 're-booling' the mark_dirty parameter.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108370 [1]
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108371 [2]
> Link: https://lore.kernel.org/r/167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk/ # v6
> ---
>   include/linux/bio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c1da63f6c808..10366b8bdb13 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -227,7 +227,7 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
>   
>   static inline bool bio_flagged(struct bio *bio, unsigned int bit)
>   {
> -	return (bio->bi_flags & (1U << bit)) != 0;
> +	return bio->bi_flags & (1U << bit);
>   }
>   
>   static inline void bio_set_flag(struct bio *bio, unsigned int bit)
> 

I don't know how you noticed that this was even a problem! Neatly
fixed.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
