Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9E5BFF87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIUOGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIUOGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:06:08 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2081.outbound.protection.outlook.com [40.107.96.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74095E50;
        Wed, 21 Sep 2022 07:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck1ORKww4o24kw3oAKjrlOV+Ll6NTJf93PKnN+oV6uWTlTeqZymJ6rrasaj6YBf+N5gGkBsMK7CJGI5TEs8x4SE24I04NL6YMY0+nf5t45UGGphuK8S1HXJhSHTZKy7ggWDpgp/PHrnrnRv8xFtjtvZeyYTz8vEQc+ugJB7SxDHC0JyrU2tMkmJp8EeMB8Ql62vzZj0q7fAh27ZScIiTsTGDme4F/6cYcKsZG2pT2ViUQaNC9uPAwdt49Uji5B0p7hvXKOCH15w7xZhk/JD1rr8J4ihb6e1oG+gEd6Prl+ouENJGJeEr6swNmADpC5lM3k5BZ6v5KrFOystISZtUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnbcf0NY1gOHPiSwC6e4Zigp7OR5dhwF8IPDVjyFivE=;
 b=Wook7gflPP/EtsHP/DhN+3/e1nElkSWPBH81wmb1b1ZRT6HyjRtgO2pBKrcsSRbdpN93pFRIFahvDRjGFzFNTmN6375QpS8s1dja4KJQBFzV6tZN7VUhZmiT166obtAwE7rksG+GpZ2W3wrEIZqZ+mMw5UHGKaIQjUnPz0FRNkUHOar76r3acvCEtdp9LPRwxEZ+myczXMRObViwuiMhIORjCpelzbmbGzg8NdtpTJKqL1UhwlalcSovwQ04VmJ9Jda9t5PaZ9zEe3Y8tBhf/EefVuzWT0GWUazeyCBiKYai8vheD+Gn2nch7Hk4uFDKCQERkBXz6ulJGi5Alnz77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnbcf0NY1gOHPiSwC6e4Zigp7OR5dhwF8IPDVjyFivE=;
 b=KjptR+miM0BpcMIEpHLKPHA0aLdTEcRa3cg1uX/NtIGgocqXclYwCwV+6a2kRN82WnHzUe+nMEm6nRlnNb2XLXufcZOplCP5mJQDSmaKF/KjWDNn04bKJNyl07Yvg0XQWfzWSvRAzkFWhm4tkT1lInWbgLwvHiotoAll7gt4UKIujcP7ZLY8nOZdecgIOeVqJ0LtzDDR1Jm5yl3/v0JlrdxZW9MCMQcjtcxl3cS3eVjk3u6GJm9blHLBUICMi6QKMPUWnXghT5Z5Ascqtp6TXJYBHVfPmk0ozVdHGis2ajpnfSutxv3nCUhM0zJZsR89rc+TJ/OJPRVYC+UEyOpTGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 14:06:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 14:06:04 +0000
Date:   Wed, 21 Sep 2022 11:06:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 13/18] dax: Prep mapping helpers for compound pages
Message-ID: <YysaS5LIW1YYKSKd@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329938508.2786261.5544204703263725154.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329938508.2786261.5544204703263725154.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be81a49-21fe-455e-6b7c-08da9bda6bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHeWvIQiTK/IeuEqONIInIj1LjAzCEyWZ4hpi9Lq3v0UzLGtEVQCbItWFVn2ybOa8+bMeiSAgIgMqPrGO2EcxcqeepPX6h5lR/Bhp0ViEh5zl8Y1371AiDeQv0S48vYrf3KWx6YCSVZqLCZxt6vDkwYK2fcorJIfCHRPa4xStDjOHBxoNvTdziFS0/rlyA+nOZqf9IRSdykoxgvI7bYsXnkFZi2OVXd0idqAkipA5CJihTrpqFAeEXWTn5jq5Ro/6nhBqP/lyQJ2Bzxv6K+JpT4OjTrDv1OZNq3EzUnwv8e9re4xGpUpX+z0yjNKr/PZhVuwPGTw/CLBolcVApzaJjngy4t+NEaOOkA/arO/De0CVKwSkR4GPgZfG+2ZiuJL6xRowHoRsboDPD59YHsZqmjNHIr1ed8lEFroEMSK6LwFNmFRa40LtOeKz3HW7+HkX/KNQ9+Yb4HPiGLci0fvUxK4L7sSrkjKVw3/SsOLyiMjHYZLSycvD5pm8MdfXQaZfVANSf9NZHn9/1HQo6rD1RA+h3XR++8dTRMI9/XcOvY6uj6KZozf+r5ivSJZdbY8PUyITZBS9ZZW0oFmKIifSjw958CiRU8fBBjOKgFIafjCLjRZFHhuy3/Yzdk1qqdPcbA6WeEJiWj3gE7Cr8+pm3ZKAVR44+myb+iv/g/kxMy4RMrBAQwn8IOy/iYY/slqWKuuj99kGXLsPpjaPY1lIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(6486002)(6512007)(26005)(41300700001)(6916009)(6506007)(316002)(186003)(8676002)(2616005)(54906003)(66476007)(5660300002)(83380400001)(66556008)(38100700002)(7416002)(2906002)(86362001)(66946007)(4326008)(478600001)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QKRVaS4TfklOqRQjd0JQJIxmiItFkTzmTogAp9ChxTDc/3qj0YbRe+iAYWLm?=
 =?us-ascii?Q?TxYqZZ5fngr/uWFLCQ/4CZHJrSLMTJ8QlEjnrnZYfUbeEFHcvSL+pyq/qkwI?=
 =?us-ascii?Q?m9TTSDvBlQ+bKfGZ90dnjLJYZmmmaqXRX0HTdEo3lFZo1mu/IOlfG9VLsRUo?=
 =?us-ascii?Q?cFd0ptRZ6qi30+4La2RAv7ildjFo3TLSl0jA6QIsHO6RsWsRPgdYt3Kd8yD5?=
 =?us-ascii?Q?wH+ghSlr5xcVAzopyhftCgmYocLoPqAAXVCK8IpZsjcDXeZubODtovPDb5gJ?=
 =?us-ascii?Q?QFjepURPNU5XzbeFgLoYDeRuFqlfIwUawqVEVyiOK6TG01IqSyuWTsgszrt+?=
 =?us-ascii?Q?x4UnHzMb0NKbnyIAepfbqeg1BtuX9oQHjf5lUMqUd/twOWV0MMb5yilf86C3?=
 =?us-ascii?Q?QDskKYF5r5JvVK81ZvXSpWyALgUYWWfPhedKllTjH4+1gvGC63iI0ey7Yofu?=
 =?us-ascii?Q?cX8y5WzHbLoOtGQhXhsZjhLrdJptvu8aL7pG2Gzyk4W3L5/TUlCk2jGI2ZJ2?=
 =?us-ascii?Q?51w1oFM1qwkeVPc6bH22ffJM6b4Zcr/4LRp3b7l0jLMtgzEahmTHXPYKExJD?=
 =?us-ascii?Q?GB0xBDIpSsuviZ8BC7fUuYg2BdiBlBEaURERpLVBPzZVx8vHw1N4l0Kk6ST4?=
 =?us-ascii?Q?1BWqpsh+rmTd4vHC/7MVdM8KzsGNO3+V1MRPwdE+S6cDRXO0EMfkNGnizPZX?=
 =?us-ascii?Q?/hJYE9QEo2/EP4fvIPHXn8pFvNTXEoI6JAoMyBFYfep65YvOrek2gnZ+sMBY?=
 =?us-ascii?Q?g/Sqoi1TCavmF9GoujlfWRf2DuubJKPgQeCALOM3PAMBB4ZOFxNxZPtd43TX?=
 =?us-ascii?Q?Zw0MD4ZadORfAVeIfG+8VtfMXXfDH9HlPVB+J1xnLDxGDoKsYMH+DitBySDE?=
 =?us-ascii?Q?RJkOVotPafP1xUQ3OCWpPzCGl7g06lu9x2NjtpVjyA0dug1pdIp/woJhEZiB?=
 =?us-ascii?Q?prrjtJh+gbzAKpI+c6UnbGpNWB/PzpLA/5cKgAByEmtHUVidvw7T8JZdxgjW?=
 =?us-ascii?Q?kZeoqYqVxHiG0g27f4KbCevBwIp+VTm/IXNUWWpI4qz5BGBEjcXQv1u8tnvf?=
 =?us-ascii?Q?XE8z4dmsf34pXbk5VGGA4xnjYsC8hqe/3xHyiOgoeV+KHn7ZEi8jJsrW1FZc?=
 =?us-ascii?Q?1amIBCJcQzAh9eT00rCnknd+HMxUAwhzOEvqM3cclhp+gI2MCQLcheuCG6UA?=
 =?us-ascii?Q?XGEIJ/LjobJSRqxP1TaZaOaC2dFjfmCgHLEe7Jc6sTzxtZtsWKOYTGf7EIp3?=
 =?us-ascii?Q?BtgbjklUhPQnkYvognn1EYEQ0aABQLDIbSQej9TWpC9tWrPYKJ26FruBUkFI?=
 =?us-ascii?Q?0ntpueW+291pt6iVGjWT8pCAK7Uz24lcSfU7Tys6y38D3pTlUVHVOts6PfsB?=
 =?us-ascii?Q?mQSFQxF6sFeV/CneCVSnN/yflCaXGDyoiNqKtyyM3ab/qiL0MbBAEPFCyvSl?=
 =?us-ascii?Q?75+78QtU8Q2xyjnG908IAPFnRTtVrbpcVi7iC7V7h3bSBIvMB0Y/taHgq+Vy?=
 =?us-ascii?Q?Ut8mUAWJ4p7Pn+MDOSDr6aFCT7OVOeokfWbR+aqEYes/aq8jaKC3D1zmjSD3?=
 =?us-ascii?Q?WNg/BObBnnE4kleFkYh5+WdsU4lWDUNw+wTMqnM+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be81a49-21fe-455e-6b7c-08da9bda6bc7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:06:04.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpjo895RaBqPkLeMUNjXfhKJ6ULgwdy/byBC6CLuaJVPD2wr3GCVsDlY6DsI1O9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:36:25PM -0700, Dan Williams wrote:
> In preparation for device-dax to use the same mapping machinery as
> fsdax, add support for device-dax compound pages.
> 
> Presently this is handled by dax_set_mapping() which is careful to only
> update page->mapping for head pages. However, it does that by looking at
> properties in the 'struct dev_dax' instance associated with the page.
> Switch to just checking PageHead() directly in the functions that
> iterate over pages in a large mapping.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/Kconfig   |    1 +
>  drivers/dax/mapping.c |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 205e9dda8928..2eddd32c51f4 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -9,6 +9,7 @@ if DAX
>  config DEV_DAX
>  	tristate "Device DAX: direct access mapping device"
>  	depends on TRANSPARENT_HUGEPAGE
> +	depends on !FS_DAX_LIMITED
>  	help
>  	  Support raw access to differentiated (persistence, bandwidth,
>  	  latency...) memory via an mmap(2) capable character
> diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
> index 70576aa02148..5d4b9601f183 100644
> --- a/drivers/dax/mapping.c
> +++ b/drivers/dax/mapping.c
> @@ -345,6 +345,8 @@ static vm_fault_t dax_associate_entry(void *entry,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> +		page = compound_head(page);

I feel like the word folio is need here.. pfn_to_folio() or something?

At the very least we should have a struct folio after doing the
compound_head, right?

Jason
