Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4340433C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 03:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348992AbhIIBvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 21:51:38 -0400
Received: from mail-dm6nam08on2124.outbound.protection.outlook.com ([40.107.102.124]:14432
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242103AbhIIBvh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYOdbDROFXTajd2SCCu93Y6Q/ngqHCMsphLEN2/xbN8Jkv97icybJvnbeK5nYAAno2SJbRVAtlaH0Se566dKKaF9vLtxEQbf6qu4w/oiDOZjQaji5TgfdKq/ZTk2nkEfmoLzF6Anp2yg81jrgaUlM3GzVJKttsBBD8vwYrTd+4VcaUNS4Ib47wHN5Y8gGgk/lXSwKPvYSoXdDwgrFNPHmk8DPTer5h+ELkj4C2EMt+Qu+meCoH51mQc+ltE2HYYmf7PgMI7p031wXMOTDsENi6eYwMuCXn214Dwx7D7+MnpeUPJoeS+8QLNeidWcvDtkh1P03mku4gKxUNCEYexT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B+x/gMMEwxtzTBNuvMUMMaW/6xPXJSKBcyCfi120Mxw=;
 b=ON3u8c+kY6GQGtPYt7f0PfcoaE+UsyXfsv3A9AbyKhPfSn4YMYKmmvN+FPFlMO1ef3qarbwQ2Uyb15PObrfKsmmJ3lSgOS4rcrucqM3qDRXMpLUnpuUU4JL8/u9hn9BNolCC8kcAJPGZwHXClFKsFEo/ED/258/EGDy0Oqn/UW5kIMoHnFToBKxNEnRPF749J16Mi3HSNT+nGKhkxl8s7Lz+poOqRVgvreZPxROnUC+/R4+hPOqnxRo+auvVsZwO4cLoZeZeEyTqeTYq/RgK6lgRq5Yf2QGs3jdUezfCLSetA72rOLaIQ1TdTKH9MypmLG39XQYHgWqk6sTKA3mc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+x/gMMEwxtzTBNuvMUMMaW/6xPXJSKBcyCfi120Mxw=;
 b=PX8Jn0dA+FTlaOVdgIivX7HNuLizGUDJoHGIzIyliFsb7YN6/MhQWC1haPkg6pp/Uwx4lrc2sfXCR/HGzwOk5rw4PhvgnxYnB4ye5Fj66B5+/HcKd6jjr2z6B4+fNPVxwJxPZ/nD5A4KK3hI6zJ5qLUHLGfgZsht3hJ0N14GKkI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR01MB2688.prod.exchangelabs.com (2603:10b6:300:f7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 01:50:25 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.022; Thu, 9 Sep 2021
 01:50:25 +0000
Date:   Thu, 9 Sep 2021 09:48:49 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        jlayton@kernel.org, bfields@fieldses.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [RFC PATCH] fs/exec: Add the support for ELF program's NUMA
 replication
Message-ID: <YTnYgcdkjL8gFExw@hsj>
References: <20210906161613.4249-1-shijie@os.amperecomputing.com>
 <YTYE8tBNAhK0MXsY@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTYE8tBNAhK0MXsY@casper.infradead.org>
X-ClientProxiedBy: CH2PR18CA0032.namprd18.prod.outlook.com
 (2603:10b6:610:55::12) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj (180.167.209.74) by CH2PR18CA0032.namprd18.prod.outlook.com (2603:10b6:610:55::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 01:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485319db-13de-4725-d422-08d973343103
X-MS-TrafficTypeDiagnostic: MWHPR01MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR01MB26887D75B83E34B05D90A460EDD59@MWHPR01MB2688.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRyJgiJGVVKnmZLtGSCm0/jWc5+DkewN+YxBO4DgpqPZrHjighYCsiXyr5/+bS0JwMQ+cgeH5z2hnIMGAHdp29Zlb1Cl3rNAMPgxRx9dihauH1AByRKyZpP5XcLYoWbGqER/LEyQuzTornHQ1C49eKj50sYt1oNQVoqB35cH9X8Jw/Meq2Jj4xc4Un5EWDEPzttBF+qVquPK2IqFZS2Kn/BPIRwEIyIoa2KsgtKfrb2x72dF3nqD927IuyGjvqKML2nG7diibC/MYFYYIksryk4fwnWJ+VzjnaFQJkb0zka78qRkq4lBiIO7Jk7o7OGpPIQgWz2lJ0hzxhoL60QlLBeXdoCJmkQAKVSf09Vb02AZX0C+5GLkkP3WFyIpVlRo2tgubBourwMQw9U63fgv5NzoRqx9muOjJasdCX+m1EPYuxZyXst5x2asHKPafO2lGEpzNBG6acChOKKJA8vzGr2J0tk6bbduNIIkG+3dEOF6PkCxAgkEMpJE0iNsjK6uq10nKTFWnupA4O2hWavG8UAHWEX5VoHMu0boNVW/cv5kkaRPlbjylywXzwTEoUuqN1ss95wuo05gCcF6MbK0DRlllo0MZwRDRWC7Rr6mlgtNYXjKvCkuJkDN6lQT+WjC7eGlHrRb//2TslWMsybPB2IwNQRQ5CdiV1n475zj2YlV1thQnfpQtLKvYJTfaQq6s56sszZB1FtlnFthaxE5Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(346002)(366004)(136003)(6496006)(956004)(6666004)(66556008)(38350700002)(9686003)(55016002)(86362001)(52116002)(2906002)(4744005)(4326008)(316002)(38100700002)(186003)(9576002)(33716001)(26005)(478600001)(6916009)(66946007)(107886003)(7416002)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIZerXXUp+I2pQTO6YMkaGNQyhUxamD/xMh9OlUwAgE5RTK2tpCbiLZCkUOD?=
 =?us-ascii?Q?8Hb9H4IMPR8h0sYFiXtY1kVpJ/z9Y72JD+B0SnYnthgL5Q96AHLu9VqgGVOZ?=
 =?us-ascii?Q?eaAfBxqX2qZ1RQu1iyR0R/piyfSNeKqlgPAxjXAzni5p98VuNZUWaFLRAoAW?=
 =?us-ascii?Q?cLGDMt5YwtViO+vC+HySHJmxHlZ12rS1i0B5tTsXsa3TBeM0aKSuP7IRPlS+?=
 =?us-ascii?Q?a/q4wAm5y+t2kDvG/5Ja2DKndGIbQ73oBAyjoM/mn2biQqA791CUNXlTLv+C?=
 =?us-ascii?Q?LyfJWwu/YB3nFJeKvGXQ+C/v3sH4RqdhCM23i37DoWtqSgN5tZwucYlBsSt9?=
 =?us-ascii?Q?7sqtUyetiuVtunb9vh3Hb1Vj2a5EjHkdTr/Xyg3nB9iVAxR3lPhObBbFomPL?=
 =?us-ascii?Q?txBDUIfXC6bMw9QPjaVgt3Kw6tIi+oN54G3wjsv+3uEJQcUxklePZsIM3wGU?=
 =?us-ascii?Q?eNiBVC/rOyzI8yQVH2wJHyrzcnQQPufbw1LFIZgROaXA86YtrS0tj/RNwbDS?=
 =?us-ascii?Q?Y/yL7IRLWMNG8W43SIvKWGCO156hZbnB9fNVGNY7LOuyrAuruO1/Y1RTipl4?=
 =?us-ascii?Q?/QH8ntY7xa72kb/tRhwGf+Y9L744MpOfDXrOq536Fb/zrHkb+T/OnystDBB5?=
 =?us-ascii?Q?TrsTqvitAm+VSMaDq7LfqsRImxTVkP/LaLfMwwiVnJ/RMezkBCjUHujEauDB?=
 =?us-ascii?Q?6dPRHaUJduR6yYQDk8OjFm7z04zF/SoAeDof/0UEN4SFkZJOmc/gz/7MCd/o?=
 =?us-ascii?Q?bi3UiG13ovmRSU2mwOkin/Kk/ejtOB78mB+DFTELBMxO7Wws3MaH0oSwli/Y?=
 =?us-ascii?Q?CaRiNEN4P8igHa9aCi4TMnsZUqYYWjjCOJhuOIj63oBMezpbSPO+it/xwIBB?=
 =?us-ascii?Q?z2GAYwXxD77rOXLOP5vaC2EWuKdpnMNwAfUMM3acdODhXT0dfkaMqnHmz9Cl?=
 =?us-ascii?Q?/tu2B9kOr9ONiugJI8EXYZKT1jB0hAGIh6Vuu4s5FOa5gxleb7cvK88UTIVR?=
 =?us-ascii?Q?2zJSnIeMW8suip/beTPnimXZIP7ZYwWbKGrdCYWJHzQtyWF9QQWv2TMJ9Naz?=
 =?us-ascii?Q?7GsC+pMBi79qgFZ1Hx0phR8lTtbt0qnCCHKJCi3aY9D3PaYlWLk+4Aklyr0G?=
 =?us-ascii?Q?6nNjAhs6lYNceS+S27OrPnj6OAYT6W/GTYP8ZVQULZ2oRVUwi6pcl3R5ls0W?=
 =?us-ascii?Q?UvmUbgOjwZodtpRqZpobI+myFOdTahI5y5NsvNFCJcL2Z6scH2N7hkx8dRF6?=
 =?us-ascii?Q?9xdIQH+OgaXOXkmYMFpoYtO9G34N6/Xa0K0/GYrPSPfclqbyNXkDduykJkBA?=
 =?us-ascii?Q?ED9QVkiwGQooOA44UoDv+D87?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485319db-13de-4725-d422-08d973343103
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 01:50:25.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A+RnftRY/d/E0uCDuf3APFTzITZ88TPkMkYPhpobJlw8j4fKe3iAupcO+FwhwzD/HvgRWiX6/NGvmgumiVMZVguELA6nbyDbxCPIaV/P8uMR0toiJvsuDDA/8WTjVvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2688
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 01:09:22PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 06, 2021 at 04:16:13PM +0000, Huang Shijie wrote:
> > This patch adds AT_NUMA_REPLICATION for execveat().
> > 
> > If this flag is set, the kernel will trigger COW(copy on write)
> > on the mmapped ELF binary. So the program will have a copied-page
> > on its NUMA node, even if the original page in page cache is
> > on other NUMA nodes.
> 
> This does absolutely nothing for programs which run on multiple NUMA
> nodes at the same time.
Yes. Not suit for that case (Mysql database..).

> 
> Also, I dislike the abuse of the term "COW" for this.  It's COF --
> Copy On Fault.
Maybe it is better to add new flags "NUMA_REPLICATION" in mmap(). :)

Thanks
Huang Shijie
