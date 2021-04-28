Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C088736E1B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhD1W0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 18:26:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:44100 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238414AbhD1W0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1619648760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rYC7KmDvHXFkRsiOmWr3nRu/K5AZ0auJBMGf4Lh6VY=;
        b=ga+rvY23WqALt21xKB1qXITm658olPRLdVu9fsnVet7g0WwVZW70V8rww163oefW8Nt3gS
        vET7deeBcNaIIiJ/AtTpEPJLIy77Z04shD4BUkXiLQMM/TUxrMmoG5PvjZzQjd75xCeWIP
        G1hPKENpLQqYkFBaHxdhV7T8En4OOnE=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-f4BhXrVHPQqjY7zPMPmmkQ-1;
 Thu, 29 Apr 2021 00:24:23 +0200
X-MC-Unique: f4BhXrVHPQqjY7zPMPmmkQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZhEar6unph+jB+0KRWmWmWzItvSOM/EGvWGWQvtFEcRporRSVN2xmq2OG+f0YslcTi5Vq32GH3dAFB4FN3CftwKZrrqJQgxMbZHnZENP9S0ehTkpMTko3ez8Gtacop3SwO8T7LyDO0Yc1mrJjCktNAW4wXmOSZiw86ZvPM/0nSaItbauGnRIz/EPPrw37a3/2z2VRBC7tVQZkVXih/xyH9TY623IAJukp5Cb2kcRjwZEcuYMlbFJa0lBhimc/KoxhAHxb7MZCyi92DRn1qLAQkeU5OxLTg7wNjrJsujiCSJ2EzwBy2NNzYldJmIfEI5Yc3dFRtvIVXQpNUmEjyI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rYC7KmDvHXFkRsiOmWr3nRu/K5AZ0auJBMGf4Lh6VY=;
 b=d93LBhMHEVxUIxZxe19vLBPT27rZ9DQ5v9/ZEoCDbeQN3BY404U89nRbS3yViIM7u6mF36DluH33PtbsgC5DD59gek7cgZC4P6HAWELEIL4f8HG1QDLp5+j0OXft4lic0xjv/IqcHoq68JlbNSLbFvdPUvh9xuEJnv/ANEaJLrgobFn9ugsfEoxDMCcEi4MlcVU97hQhinP7nrBgcRkwakVHeVdsxqhdrrlO3yjtKmNGkuHYY5I9wTjcpfay3Eq0VUA1GqeXpqqq5QCO5C2dq131sXgjRa9lFXwPdJgRfUPVV1gPxyBLiJ2srng/xuoXzd92itRsUzRrrs18Zpb0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0402MB2909.eurprd04.prod.outlook.com (2603:10a6:800:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 22:24:20 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4065.029; Wed, 28 Apr 2021
 22:24:19 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
In-Reply-To: <20210428204035.GD7400@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
 <20210428191829.GB7400@fieldses.org> <878s52w49d.fsf@suse.com>
 <20210428204035.GD7400@fieldses.org>
Date:   Thu, 29 Apr 2021 00:24:17 +0200
Message-ID: <875z06vyi6.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:3898:6337:f59e:f055:d0d]
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:3898:6337:f59e:f055:d0d) by ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 22:24:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff0f4c9-df27-4f55-1777-08d90a945ded
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2909:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB290985FBEB8F27A753CD0366A8409@VI1PR0402MB2909.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xk8dYlRD0dKbrNVBsgNAUlgTG3KXItf5S5OqZ+1t5tJIVpPnEIV8zQoPqTdo8yn5kIAmF/HOP8yrrVlECvKNOn4pC4ubr4ijdNRcaytxkjM51U75CmUeQAcrc+SeyqecTRytCLzfOhan0zF85yb4cHut+iI32YD3JAu9NWnrWDeE5fICUXameM4SkdfA9ugFw8LG62H6n3fxYFxSDmK94Fgg1XToL1/eayBnFFJ0rmXtBVTDyCmOR3Sd9TldoJelBhgsu94HGXHsxP+paDqhJxAMQ6S7FQsjKcez0ZrvKmUpYvStTJJtpRBRv7GsfqybybsZvDzhUEZEUvMX+AFubWktxZvngpT6GZdjbb7zmFqhRqzRLPdxK4TTn37JawKUhhAhnIvVSxHrIGlQz10TPcXUbcNWczvEfHduA8x/in8JMRMTlvhnC1CKUIQzLE7W8GqMN480125inLGusgGS+V3L9Wcu7S9JQfSRD1z85fL/ZjhTznakTkkigfa3bqbA8R6SgURRgrWiy0skHssuLWQ4UInav4erwA4pXqqsEDkQgvAlHW4Rf1vLSGQkF3yRcar2IhvZDiemtFYhup3iyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(16526019)(4744005)(7416002)(186003)(6496006)(2906002)(52116002)(36756003)(38100700002)(5660300002)(478600001)(6916009)(2616005)(316002)(66556008)(6486002)(66476007)(4326008)(8676002)(86362001)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fzV7vC3c+yooFOHvuK9HccQwL9nqJ0uiYySihKbJRm7ICbkTHg465OrLgPPOAI5Phyejh04hL1l9ixnNgS8yWFXRAuaCtI6ZC1dc71l2nmmpuwe7HncILDDiSUakACdK6yburgPsdwy768L6Bwa/mHeApGwh3QAxCHkaOxxCR1wG2v8SEjsJ33wxnbDZu+W+ubjva1DSkqhHMPEESpj70uS0xXh3j6NSjwGpX36QVlfdPHGSfPdKAqda1cPCNJDTRZxZA+NZ1ABtwony08cMnMRZXLgyGVDVnoTsUFTh+XWxc9bA5rc/iiBKz7b7cCs95EG9QcOfghZGTFN1bUl3T9XBHLJAFeRq7L4cm1zkU5fLizgO6yO/guV1gvcU2HjTkEy8jvCq0VUuhI2HtYlaJ6JqsL1MRZGFhv+Cog5p/5LvctdnjJ17gxA11ZZXSPJj+klSh0FPQ3M6gqhQI88PzoukMzzoZPIl203086mRmM7yRdrsl55z7i4jjW0kCVBpTpMswX1wibCWwVlmy1xCMdYNZGDkI/Va58DN3gnQR4Lw8tMg0ZMwDkAEy631XQnjtsrSZXwyndXaMdzmGEztXVodowdkxSxwEIah4IYzqjOIY+sd+eD3yENJjGhxGN1lgyaY0EpsJvnP53jixr9kaVYmiruAkHOSKIoKR1ia0OcnmJlMmbXaJAVsOMfdvspNFtX1MioNhAloBRASA4Lrfh3E+M0jOM/O0w4lJybZeIhnIX+/FsWYf4b0sDKoVIaXQzRbK1lKcEWzj2cVgU/gOFDTOqkrkaAqsEU/8rXSxT4=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff0f4c9-df27-4f55-1777-08d90a945ded
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:24:19.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxBqFVP3dpYOw0N0cinAh1pJMM0OcL7pMotH+Ws0bA9G3zn/kyhG/O+PEYIofoaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2909
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:
> I'd rather see multiple patches that were actually functional at each
> stage: e.g., start with a server that responds to some sort of rpc-level
> ping but does nothing else, then add basic file IO, etc.
>
> I don't know if that's practical.

Although it would certainly be nice I don't think it's realistic to
expect this kind of retro-logical-rewriting. AFAIK the other new
fs-related addition (ntfs patchset) is using the same trick of adding
the Makefile at the end after it was suggested on the mailing list. So
there's a precedent.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

