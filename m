Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7C22557C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 03:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGTBeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 21:34:24 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:57703
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTBeY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+u30V+VzXvK53SE5+ZLL0qGImBJZeHM/2qT9pmJnv3Nk58ze7AuiK969/xOGii7wY2KglJzObgvIP81U0doF0Fss+zigK09y14lnSz5oBhAXnr9n7cQfGo0JSOrkpnNI5/uGtmcafuqyC9IeaSLfm8z4NluhlbdhFK+0N0D0MiN3mFWYJTzYaBgv5I87UlB082seTZJX9BaQM86K7GaP6Jp6FdJ1hy9bD0lqNwmmIhOfBGNRrgcJVxnKuHk6Gc6A/MIHLgDixJqNLdiddV/uMdvy8tXJUj5Rha8uisitkIVmRU0EgdldpNGacrQzKc3sjg2ISUNwq5Z7hup/BgIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et13Slnybrd+bQP5o7Uy2yBTThW759M+6dyXbQuA4OA=;
 b=dNC2yUAwecz8Lj1upYNhvwe3Z6DuksG/Pj3BmxHEwzt/x7OhjSA7NEnGsE+0VETYgyCBPXNu7KdR0xZWMhohgkdEEytYwgkY6r13pgAfVe/RpQvotY0rByQ8pLU1XKXYi5wnemTX5I8TDK16OW3fOuJglCkjQa80gfdtzGgSYevdU8XJHhSvWFFwq+8rWIHvdK7MX1t4LK5wm+6Qh/ZfH/Cdpaq7Dn7JTkyxjmJn+CixD+5e64PU04VnMSO3a3Z3oFZqNQDIo26foYI3NRSjYNTogmRj0TVUOxP/xF+j29C2Es7S7o7C31cB5orKezlYH0kUA6x4IVCC9PFxBvACnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et13Slnybrd+bQP5o7Uy2yBTThW759M+6dyXbQuA4OA=;
 b=ZptCPGJs9bmvSZB2TMhQMnNUBYaHADhECBnag/O5zP6bb83M28c9zYIzmVv4X+QhSUCFM0KhzpHL6JW0Zth2qOIybHV8jvS2boRr6Y9uhRQAWmKeX+CeDJBqTkcnwnSNjUf5GL2A5gwfq0fTnBO8dtuiUc7YfYgbXmTA8VI3OyU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3445.namprd11.prod.outlook.com (2603:10b6:a03:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 01:34:20 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::6892:dd68:8b6b:c702]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::6892:dd68:8b6b:c702%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 01:34:20 +0000
Subject: Re: [PATCH] userfaultfd: avoid the duplicated release for
 userfaultfd_ctx
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714161203.31879-1-yanfei.xu@windriver.com>
 <e3cbdb26-9bfb-55e7-c9a7-deb7f8831754@windriver.com>
 <20200719165746.GJ2786714@ZenIV.linux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <021ffaaa-daa4-8d80-c5bd-3a6c816d4703@windriver.com>
Date:   Mon, 20 Jul 2020 09:34:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200719165746.GJ2786714@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 01:34:19 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65829ddf-17d4-4a99-36d8-08d82c4d0674
X-MS-TrafficTypeDiagnostic: BYAPR11MB3445:
X-Microsoft-Antispam-PRVS: <BYAPR11MB34451BA1389A8294E86EC368E47B0@BYAPR11MB3445.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enQco9lYDQwzWdperdFjoy337u0CrCthFolgi6coWz9G1fgcmLaWEBHcxFYJZq9kfwWlwwogQvnx/CvRdeu43SUx1EmHU0ddGIor9QNvE+OVm428ItkCe7MRNfGRW9yxLN30Ef12JXjD6Adb2QTM2teVWbRFEsPkcdtBVEbyEGyg4FDCKJFU4hjfTds6WgXKjtBiZDsf5G8EO01pYOIvj7vU3f4Yyh0GcOdjCbShGTE0vn52OgAqKIzS01dh5y1z/StyAUO1gRS3Fn4D8faG10H/z8WfKJqlmNk7BEl9BNze/8RmV+bvecLngjDVb8igswgDLzv3/X6pD6V/zFLCMhu2pf8PelB0yTcRulHLC2nDglnMAccPgE4m35jY8p9HjU9qhFmFueBmkWxEndLC+mZaOt5HTp2eDp7o8bMbvuO3qU5PXeVkSgZARkp3o1P5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(346002)(39830400003)(366004)(86362001)(66946007)(66556008)(66476007)(53546011)(26005)(5660300002)(8676002)(4326008)(36756003)(8936002)(31696002)(16526019)(186003)(2906002)(4744005)(16576012)(6916009)(6486002)(478600001)(6706004)(31686004)(52116002)(316002)(6666004)(956004)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GDQ20X4HnH1FqbNR5IWSkeV56/xS+GVpfM6pB5dO4r0ANGdcouBOCgoMqu2JfAFQK2E3AhMtIMXOY05MKubH3sWKya1BDkPtC1gjVhLhcfZFvYw3VEot5v7QSTzOuMYzuBYuCVRwma9tG1UHRv4LviMjW6Mh4Tc1kLtkR9ZDe9LrPOd0KSxgXd2quGc+HOZKm1TggXNDRO5mxceLCP7wRO5Qp3LmBhAqsk63+qUcfEoKhiJ8MSFB4tN1o0z971AxNg2o9tKYcpZxqBu1y1bl2wPEsW0SN7unuHpkvkF2aLGu9Kv0Gq6A86upxfxl/S4LPyjKB7o/rSdY6lmKIUQsfIfBVboOTxyiRAI9aAPpYwTVpfAWzVsrkL6axUdbHJFJpqRY88azqmuC40FDpEPIPCuzsk5gClYUP53yyg2W/IS8DVxaoGjZY+GiB58kRFE5GPNFs7F8vkeXKDW5YS4+RvMuz2/deK90NATT0qK/lzM=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65829ddf-17d4-4a99-36d8-08d82c4d0674
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 01:34:20.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAodzLG5tVxqXF8f868wfeQaPJIA9Dm6dWqoXeY2PiEi1kdgC95Eh+Si89fGiHslX3Dq1AGNzT1wKWQfnx/cQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3445
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/20/20 12:57 AM, Al Viro wrote:
> On Sun, Jul 19, 2020 at 09:58:34PM +0800, Xu, Yanfei wrote:
>> ping Al Viro
>>
>> Could you please help to review this patch? Thanks a lot.
> 
> That's -next, right?  As for the patch itself...  Frankly,
Yes, it's -next.
> Daniel's patch looks seriously wrong.
Get it.

Regards,
Yanfei
> 	* why has O_CLOEXEC been quietly smuggled in?  It's
> a userland ABI change, for fsck sake...
> 	* the double-put you've spotted
> 	* the whole out: thing - just make it
> 	if (IS_ERR(file)) {
> 		userfaultfd_ctx_put(ctx);
> 		return PTR_ERR(file);
> 	}
> 	and be done with that.
> 
