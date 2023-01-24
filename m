Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478EC678EB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjAXDDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjAXDDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:03:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421CB301AA;
        Mon, 23 Jan 2023 19:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoO85c+Qxw7FRV63PnFsRoEUldqWJyu3Oqayd89ZvgnZnEV3mD3KOE4MhoJ97g1nsLSz3U+/9K9MJL6ZvrPUuTC5zfjlZdl5lnioPxdqYEMPDibXL3oeAD4WDHOe0SF2SCDsd7eV1sR6vFc9AUC7buKfk4jIFGtGeV+OYeMyA5Zz49tV8M7cYjiwKPaLNMuRQ4fXqcmrUaKgdHWOOo8K7IVGoJFGinWUbfuUmzFyk1TETlpFbPhPx3EHWN6mNRrDn7gaULm5X4AW/Rt7vKFkYc2AXWI4mJdttY0PGStuul40RiVs/25qw7jar446I4Kv/Y8MTur9RqEHVUl84oFLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbfs1ooa4xDtwWTy5RD7QpgnOxn3Eo7uMAwo+j9AP6o=;
 b=cIkAx5Vz5/x+bfHY9ve/CsTAygaSbmYzwojnEX0t3Kjls/IqttOe0kejaBxnc0u62rSFPeLHheAQfceuK5J/TPVDsaeKVFGwD5lNInUdGrkuDBObJbGiFupC9604exoVVw4XUp6HDDUgQgZO10J0G6azVR9m4ITHIaETG5S5jvp3GvPIh9d94w+sqbjTwZk/+IfTwgODHy1OUFH1ot2IHbi0AYBfKzKNn2a191j0tVrV4w6sSoWisNP+U2Yyur2xJIrvbQM4n7DFnez79gxTFvrgDoD7avr4TshzQG5VLryQSp0saBbV/n/w+xRvlk01sHS8srn3sRdZAhhG66ajGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbfs1ooa4xDtwWTy5RD7QpgnOxn3Eo7uMAwo+j9AP6o=;
 b=aEkL1P6HzuR16oOsftQAeJx0kuaeAlvvuTg48VxTZTxT2FJrjG0vHxDDK3ocqsffKLzDxNB49/KfLzmm+hPjrCTmWUL2tYr4MWyt9+1RmXBOaGslukD7Qg288wb0JjAgrmWzbzECAGwtkawAWODbZU0pfiP6QToI//G5FimV9m9hwAZhfhA7x2J2wVHlMel1v021l9hjt17pPzYpKhiscDmcWcsd8cs58ER8A2HDnUXWLCOFdmgMrWg/tfjrkTCG6CeVHI7Idkk7JMPRKVeTc3T+ghqBLrndlI8Z8K8LMSMWR5W1xNOLgp1qMRRE30EHToUNpPrqqX9xdJzLk4UhQg==
Received: from DM6PR05CA0053.namprd05.prod.outlook.com (2603:10b6:5:335::22)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 03:03:39 +0000
Received: from DS1PEPF0000E641.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::93) by DM6PR05CA0053.outlook.office365.com
 (2603:10b6:5:335::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16 via Frontend
 Transport; Tue, 24 Jan 2023 03:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E641.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.13 via Frontend Transport; Tue, 24 Jan 2023 03:03:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 19:03:26 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 19:03:25 -0800
Message-ID: <e2de778d-50f8-ed12-208f-4b21d2099eda@nvidia.com>
Date:   Mon, 23 Jan 2023 19:03:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        <linux-mm@kvack.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-4-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230123173007.325544-4-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E641:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 9775b085-60f5-4ef0-9f10-08dafdb797a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkgYwQRyRa8ynIYD+TT21t6QR7K+e+V50F07yo5wxJElRtqdBvwV0CEDQmxeRYsKOmiDz98et1VzYW9pYkNl7YfwVVoZofLO8xlncIn6+sPuAW6vh/iPEAmFyUBAa1FvMeggQlyZLzTeGnFDNTbO79hlltly5D5Mm/yShktda1hBCP1xO/dg6GqVRjl8Po8AvvNzIq3yKjLVFZbzt6DLIIlwBf9nJgXafu69wig9gChEWnvoXxOMY3bb909owW19ZQ3y5U67TZS9TrGh83gC4qF9d6UjZ089N7yzYqnIdFKyW2Pf+QmM5Ezw23CASDorwjNJjqwz5EdrLk2vswoXCnFuGqivw2DFAiBoSQrjpxnywFj8uy9+0RLSUozYih29Hqi09KWhardD8BdFF6Rts5n1180SLyMG+cLoozA0qODGWPavSS/Srnr3kCBn++78FMWMopyQNUcAq1go156+mhqFZid6LQW4RUz1W/F76Z5Y3b5FBxWuB7qhV6UjMtzAj4rnhyLx9rlWSA6rzAQJ2Nw0iUALrYOV5taNR8276JOhjj2bsDLm7ZHG5vPMq96MDwwMJmjoQ84CJbIZKeAeVvl/Kdw/ZMBUELzAjfQ/842+FPTktPQx5ajT1DqfB1NyQOjxu/Vubl5lMYR5KQM9KR0mSoeOeJITHXwkK+oVQ9G0z5WsffhbxcwlUsVOeBMPVEU3t1NyAeudw69J+vE+xR4OcZQmzuDE9XTt7M/YbPE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(7416002)(2906002)(82740400003)(31686004)(5660300002)(41300700001)(36756003)(70586007)(4326008)(40460700003)(8676002)(8936002)(70206006)(31696002)(40480700001)(86362001)(6636002)(316002)(16576012)(110136005)(356005)(54906003)(7636003)(36860700001)(82310400005)(478600001)(83380400001)(16526019)(53546011)(186003)(26005)(2616005)(336012)(426003)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 03:03:38.9709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775b085-60f5-4ef0-9f10-08dafdb797a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E641.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 09:30, David Howells wrote:
> Provide a helper in the get_user_pages code to drop a pin or a ref on a
> page based on being given FOLL_GET or FOLL_PIN in its flags argument or do
> nothing if neither is set.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   include/linux/mm.h |  3 +++
>   mm/gup.c           | 22 ++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8f857163ac89..3de9d88f8524 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1367,6 +1367,9 @@ static inline bool is_cow_mapping(vm_flags_t flags)
>   #define SECTION_IN_PAGE_FLAGS
>   #endif
>   
> +void folio_put_unpin(struct folio *folio, unsigned int flags);
> +void page_put_unpin(struct page *page, unsigned int flags);

How about these names instead:

     folio_put_or_unpin()
     page_put_or_unpin()

?

Also, could we please change the name of the flags argument, to
gup_flags?

> +
>   /*
>    * The identification function is mainly used by the buddy allocator for
>    * determining if two pages could be buddies. We are not really identifying
> diff --git a/mm/gup.c b/mm/gup.c
> index f45a3a5be53a..3ee4b4c7e0cb 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -191,6 +191,28 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   		folio_put_refs(folio, refs);
>   }
>   
> +/**
> + * folio_put_unpin - Unpin/put a folio as appropriate
> + * @folio: The folio to release
> + * @flags: gup flags indicating the mode of release (FOLL_*)
> + *
> + * Release a folio according to the flags.  If FOLL_GET is set, the folio has a
> + * ref dropped; if FOLL_PIN is set, it is unpinned; otherwise it is left
> + * unaltered.
> + */
> +void folio_put_unpin(struct folio *folio, unsigned int flags)
> +{
> +	if (flags & (FOLL_GET | FOLL_PIN))

Another minor complication is that FOLL_PIN is supposed to be an
internal-to-mm flag. But here (and in another part of the series), it
has leaked into the public API. One approach would be to give up and
just admit that, like FOLL_GET, FOLL_PIN has escaped into the wild.

Another approach would be to use a new set of flags, such as
USE_FOLL_GET and USE_FOLL_PIN.

But I'm starting to lean toward the first approach: just let FOLL_PIN be
used in this way, treat it as part of the external API at least for this
area (not for gup/pup calls, though).

So after all that thinking out loud, I think this is OK to use FOLL_PIN.

+Cc Jason Gunthorpe, because he is about to split up FOLL_* into public
and internal sets.

thanks,
-- 
John Hubbard
NVIDIA
