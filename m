Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89136E02D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbhD1UUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 16:20:52 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:23645 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240578AbhD1UUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1619641205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFRMcWp6pWQpNlAFwvULHIA+AyHyIrarbJz56gifNZE=;
        b=KJEWEQ/0i/2NiSCsILlUGivi72kUVOoHH8OluIbE2IKDXwDqce25vgvy2Y6ksYIuJ7woVD
        lz/e8SLh0sFi7mw+yheBTgmZm6FcSAy39yPGO1mKWYHmBrph6GPUcyyakWfOtcvq/vAk9c
        hlfEmpg644yPY8JwwBxWmcxfM7IO4Rc=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-ZHeF8tiZNMOD5JskYHKOsg-1; Wed, 28 Apr 2021 22:20:02 +0200
X-MC-Unique: ZHeF8tiZNMOD5JskYHKOsg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TItPDtIN8rclb6PsirlcduOAski0XBgkp/OCk/YzrVj4bH8aMzP4YJq3MxaqaZnWJHV5NeqzIB8a98yHBbktHgIndSuvA71DcJ3qS67R9x97smGJZOa9ecZwIXMjeqjN42nF/RoKEXtoBi3gC3pO+E4y7TRGQuo45lJXqEZ8zfkof3Lx3uesfYJXDehHhvq+iLmuHX8v3sGuTz2uw4RHNPaHpU2YRunCTY5fCHWJ4weej0vfKByZ3YvveJXxVAvvM8RXWZV7yPqp3ie04n1XI/60r4mWygL6ktW3ckRE0/bNzv7dFpsz2u+DFsqOemAkUc15pNE+L/8aJi3T0+mqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFRMcWp6pWQpNlAFwvULHIA+AyHyIrarbJz56gifNZE=;
 b=Z5n+uOxBmlMu3oDcWWxYAT7OyuWUp4AJ0lPqOTOLtc5+I5srgZnq94g8BZ6v7lpmkEZtt0nrOv43tvWeKFX0YJwv5tTFviPnqqABwjMvER8GSANLMztw4Osl3xZxHg4etyseCY9nSJK8fpEfxD/w6VX2/NvA646yKM/zbkndU29gYh46kP16xCQT3ieIII5DVrvOSRVVNng1YOEBmEmm7bXwmwFo04OmojpcXPFSPR9iUqCaHA20cQ1Y1zsHnild2CSeoiZiUGtheyTG11mPvo+816yJ3FReFLsJwZFFgzXg7z4ytbsbK62f1FeFFCUJ3DvHe+TtCBvBxuuWt6ZniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB3103.eurprd04.prod.outlook.com (2603:10a6:802:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 28 Apr
 2021 20:20:00 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4065.029; Wed, 28 Apr 2021
 20:20:00 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
In-Reply-To: <20210428191829.GB7400@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
 <20210428191829.GB7400@fieldses.org>
Date:   Wed, 28 Apr 2021 22:19:58 +0200
Message-ID: <878s52w49d.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:3857:3489:4c2a:5839:314b]
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:3857:3489:4c2a:5839:314b) by ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend Transport; Wed, 28 Apr 2021 20:20:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48f07cd-d626-4596-a73f-08d90a82ffee
X-MS-TrafficTypeDiagnostic: VI1PR04MB3103:
X-Microsoft-Antispam-PRVS: <VI1PR04MB31034015094F59F526754CA0A8409@VI1PR04MB3103.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5E+b20zjKfWEh3JVFPJjFTHttcmJM+Y2tXyt+ZKb2p4C9BZvHKuEonUGRcLAxEdSXi5O7rLkpRzXdq1SMmSX2b6+0LF2EcPKLuyyYKs+lxyE3rM+SPxHXiKTB3YURLNR7djrgW5jSiGqfvbILiQvwx5rTFrJemGPpQhUS9icjUQj8uovvWWuRigWJtZyw0RYGhdkjj0NIewb8eeUo/QPF201OUw/NEGJlqlYNBiBB+K1YFj/A65IQ32rPloxcxwUvw4TaXOC2GujGM+RhpcA1rx7QgUPObvNGL4djPWJWZBekBvY4oj/zZRb8gpZEqylggOfri0cmF/4rEnQ6grmCay45rFHUx8MfUz5TNVfrI5HecZ7S8UMV+BY8Px3yfL5bCwwgps69zJodns8hY+qEH/0uv/HL+/yYkmAB5aUfYiIzLXgnOQqC0ERPWI0cSZFrukIiuEmvTnB3X9Lnv93dPIRwUkayUMHqZLIXsz0yvQ+Ig8xczp/Qhq/5MVeH3iJMTAgomo/oUh5u1GBR53MztcEXIBtuISuHsabNG7DLbZmF6jbHvyCluGndQu2RwtzD4xwNmXhG6vTU8W6EQr9ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39850400004)(396003)(366004)(7416002)(478600001)(5660300002)(2906002)(4744005)(83380400001)(66574015)(2616005)(66556008)(6496006)(6486002)(4326008)(110136005)(38100700002)(16526019)(186003)(66476007)(52116002)(36756003)(8676002)(8936002)(316002)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 27ljYt8SIyrnHdrL7un/bNfqxmwaxe0FKtCSKrl9btSoCZfaA8MrXVCxu8iAcWdcrHI19/omRf/TnMjQHJFhksXZ+Shlgq94niCx0fFPvtwFE5tlVGjEboVpxMWakWasoWkKJdEU2Miy2vu3kLN7L0y7/VUY4Hhy9NKejkcw6n4ax4PQCx/4PrvFc08SgX6RRO/OHfWZ8rkkfl/7OcpWSNTtcgx8ncpuw74Euati6+sVxKC7PKWs3GLVt3WuH4mBSPEtOAtqfyTNlUjAUtA3snuX0rrdGj1I5s+o6TX9J7NpmoH6sWckQ3SzKMPNhMoVqwrrgshS2EcijO4/Xaz+nccV1rvFftu+Q9v8cnJRMLWq6dlUrZY/VrxUHOPv4Lfi4GajT7iHFdlN7fjfr9LB4IgsLKGUFcPZ2yTIxisCiHwEmFow2/ToCSOZ4c2xKk0SXGo0ckRm1/iVFgY/JvszuInKGlFZtPBp+/1CZMi4An3uR5Sqo+MqYt2UIVu7gOWtxSVdKSJXaVW4dmlmoaGfxZ/vBXzseoHAZmMHixE1IkRXnNU41ZSsNsrP0fHpj5sfQdCXMj0OHWBhPtj+JRLYDKoYFHz9kj32LM6wraMRUeyKXQkjYCV43cag4SJRbJ8jbR6PyIcssuBmJiMFRXUl6738vVxUKW/OHlUg+qmLSGIi+GgHFoMm+n5DR9L8sTk1rPfRs7Y5v1uVqKebPhNVe2f7HxjJJhg8CpFqAff1WhYDhlljUYqAIeDcuW6z1GSUra0071ob8LaJiJqYfL/17OYCp2cLl41rKj7ylxoE8cM=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48f07cd-d626-4596-a73f-08d90a82ffee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 20:20:00.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bT8V5g1hiJv/hkYP2/SU9GYPaViEmyiKcfunCGIdD44tM42IBePGawhhAs/4RK0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3103
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bfields@fieldses.org (J. Bruce Fields) writes:
> On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
>> This is the patch series for cifsd(ksmbd) kernel server.
>
> Looks like this series probably isn't bisectable.  E.g. while looking at
> the ACL code I noticed ksmbd_vfs_setxattr is defined in a later patch
> than it's first used in.

The Kconfig and Makefile are added in the last patch so it should be ok.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

