Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18D439F600
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhFHMHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:07:35 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:1413
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232388AbhFHMHe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFleiymchMtdVWxtY4iddg8Rxfk6XOtvloQhvssQOOkm2k9Yk/jBHrK3B5MwZOyuVzGR7UPJkx8TU0me4VyY6iL1v1qhARnKWCdKZYqUE27cqSNfUjneD6S38F7eIs4NvUQPbXDQPC9JVH3RYYOuhVyh5goJBzdC13HHxZLScupL8bVBEhpoLnsW4+LHn9Hoc5QM3J7N3AY5UNFdi1fy0PzW0E1NZ8JWu7hyFubnL4NY7zqqy2US3F+GMbCwuv9FowVsAXzEUIzUepHuV8e6cvtB4fyDe2Sr2sFrE7mMY6OqOrWDDYATnewLcWsTg7QqxR7SS/nyFTdfYopiHQf2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcCMKteCzkI7+fB8Qgcyj3utrWNgS0zV/3971OXpYGY=;
 b=TKeemk9G3EN5ZjZsx1uKfJKaQP76IVdZgPGoOSN21IKirvYGkyPYAkF0QXDglz4fwWbTqXeNPltPPOCFbqboBGEtR3B52dpwU5ILgOIya8rYWYlTZCFCSB019kS0BLb3ubkXa52Tfh61RNo2C4vNyTFM4a0u2BrxhCIFspZu18ldkLWHW+cFY1gUpMpN5G0k9UpCGQTlHh1i9ziEytFlMtpgWCVVNl8uy7AVYRCBndiORjjfBrtSZS1ahAiX9MN6m9vjlXZeiySOAebtmebYpfOVQEPNoXgg5irkPTfjyRq/D8+coHU4EGHJrvc0XLqdlOjfAf6v/85lRmRqBgt+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=f-secure.com; dmarc=pass action=none header.from=f-secure.com;
 dkim=pass header.d=f-secure.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=f-secure.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcCMKteCzkI7+fB8Qgcyj3utrWNgS0zV/3971OXpYGY=;
 b=g5eVFgpfiWk18E6FD3Vk6sHOzx0Qq//w2331Y8L6XRPESxOiYrhd/t+vRy/El10aF/nWE2Z12Xu6CkgviNw7HxmeB0G+lfEB2BBSImPFUDEf1F3m7nXvd7F3zfyQ9dFLil51WFPDUD0DKBwR4LX0SAtrivMDmuT3YF+PykaacaY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=f-secure.com;
Received: from HE1PR0802MB2443.eurprd08.prod.outlook.com (2603:10a6:3:d7::8)
 by HE1PR0802MB2249.eurprd08.prod.outlook.com (2603:10a6:3:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 12:05:39 +0000
Received: from HE1PR0802MB2443.eurprd08.prod.outlook.com
 ([fe80::557c:2869:b0ea:e588]) by HE1PR0802MB2443.eurprd08.prod.outlook.com
 ([fe80::557c:2869:b0ea:e588%8]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 12:05:39 +0000
From:   Marko Rauhamaa <marko.rauhamaa@f-secure.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: fsnotify events for overlayfs real file
In-Reply-To: <CAOQ4uxiYZfQSZN4avfnNmQv1OxB5+Q=9wr-eSRXK+QkostC66w@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 31 May 2021 21:26:35 +0300")
References: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
        <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com>
        <CAOQ4uxhsxmzWp+YMRBA3xFDzJ1ov--n=f+VAnBsJZ_4DyHoYXw@mail.gmail.com>
        <CAJfpegsqqwMgtDKESNVXvtYU=fsu2pZ_nE8UdXQSLudKqK8Xmw@mail.gmail.com>
        <CAOQ4uxiYZfQSZN4avfnNmQv1OxB5+Q=9wr-eSRXK+QkostC66w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 08 Jun 2021 15:05:38 +0300
Message-ID: <87r1hcftnx.fsf@drapion.f-secure.com>
Content-Type: text/plain
X-Originating-IP: [193.110.108.33]
X-ClientProxiedBy: HE1PR05CA0193.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::17) To HE1PR0802MB2443.eurprd08.prod.outlook.com
 (2603:10a6:3:d7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from drapion.f-secure.com (193.110.108.33) by HE1PR05CA0193.eurprd05.prod.outlook.com (2603:10a6:3:f9::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 12:05:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e18d805-1304-4ca9-a6c6-08d92a75bb6e
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2249:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2249FC0827B2AF347DAD7763BF379@HE1PR0802MB2249.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yAs+Yvc4WaSM+9btGm4aLOsU1kUdVFGOcLXI39XnoNXO8sQQkjQZ3f+2aqpnC9SX0FqUBbdRYQojM0UDVjDZvG3y1peQE9qaPm6qciAq4AZib6uWIW09x8QCUmllEut6Vv+kHy/13BeKQn+kUd5yLz8+F5D6jepnXchgl3thVTZYuAcLDF8MrwojUEv3hcB+ziigG18uCtTfn6xn9uqNWv4QCz2LI+pzYl4+XlorFHdBqTTZcwUXnXR/GB/zILuLhGGzfvJ/IyfefVaOJLnsyP1X3S82Jr4PDPti8M2vtrjbG6g4FDTxXgWGdX1tX1I5se3tvfzPL6w5goZDmt0D9lEFNd6EZweqLmwOz6PwoabRQkhmLLGgMP9j3uduhzfToDbrML8Rs7QCy0sIhghHhbLEqeRcDlQb8TBkGREaDhmp/3kM5Aj0aLrjtJw7oTbh5ikqMJZ/jTxyFRr2q1635gZB1DR/1SnZNRaRJDjxM3ryKbjh4XPzdf1Sg3JP5xfe6TpGvXl/IlYuztvs1fCrZ7b9PZHBBQO0Eo5qPgEZX+0RrmclkdAIUQJ2ne3oYN0+XM3rWKTANo3wOknVwTLTt++Xr6V59RMcLJHYxbZEGz6RHAdypwSTZf3Yley7/+97sToQpOr5Oe4daVDcFds7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2443.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39850400004)(136003)(346002)(396003)(66574015)(8936002)(4744005)(16526019)(316002)(8676002)(5660300002)(52116002)(7696005)(83380400001)(2906002)(478600001)(4326008)(44832011)(186003)(86362001)(6916009)(956004)(55016002)(66946007)(54906003)(38100700002)(66556008)(38350700002)(66476007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N85RHjpbwaJFXFpTp4jmG0EdXUVYWm7Sx6n5nSFCiiQkaGjTIpqptIhyOTW7?=
 =?us-ascii?Q?FG5JpY3iZ7qAbqItwNgWtj18Ez1c8cx0j/lPEDe+EXPN8Lc9UyAduYpW9BhY?=
 =?us-ascii?Q?QR4IHGye0UbngoyOCS8netyF0dnKW4VgG60Oz0GQIew4MPU/0lY788Oj/HXN?=
 =?us-ascii?Q?e7BM1uX+qx5S71FQQz7erHUf+k5sM5MBA3qPnu2g9XWanEHJVlOJReF7MesO?=
 =?us-ascii?Q?eD8nfiogXaO3LRPUFagUzaXhwwO8LlyWEU0V3tvBM3J40dmmyIOqYm18mhDF?=
 =?us-ascii?Q?+a5JyxIQa+DnHIz5H5YaK9M4AjRsRgKlHLSswICMiCwWc0agLoI4hzJvjOWU?=
 =?us-ascii?Q?IhvCPjivdNKmWEWmett7eyeVDEQ94BjxuRHgwpjUl5Lix4OoCvE5Hl51UX7v?=
 =?us-ascii?Q?9NLsWOd801jDaJDbfwQZUEFXkdesPUlUHMhFdEU2KXRRcTkBTYrhUPre0PkM?=
 =?us-ascii?Q?8Xl5xoBIlaOD6p5WR3b4+bwpS6lfExmtaPmvRHrYIOOFB/St7DRUEuvxG82G?=
 =?us-ascii?Q?iwvUgDF1t9vGA3vmyJUUfdKxpMse/YnUMIwEGGtgIlFwsPCnDe4LJUNKvH3l?=
 =?us-ascii?Q?d8GflI95o3rbEbBm+MI7SpF2ZyVOgyNUoU2tlQV+mdF/Krs0vKIOoiFSvleE?=
 =?us-ascii?Q?vpYi7nbl1iMy23XpOuaXH4QmdfWCWyLQw/jFI0DyE3jReGpVqgGh0V1avRPF?=
 =?us-ascii?Q?5i2vtBfQHbXriYMCvqoPebbl/+1VHyzq1/nUZaRxt6AubsrfBdpOQKwYCckO?=
 =?us-ascii?Q?OZAAgvYqiP0OIV1CTsK/zDEoTkuS91XEa3AjdqLwgsoSL6VaLYczQGdtHdFj?=
 =?us-ascii?Q?mqM4sGLWMtCwaLQ0imIx3RgedbHGxmdiEOlP9XI0RDdRR/P/FabWwQjzSDnh?=
 =?us-ascii?Q?yWG8aDUsFIJ1ywLTGtsqrLdtnKcebCvrNJLRbRtDs1yZT8qbMDYGF56XxnZ1?=
 =?us-ascii?Q?dzOxCRBkUQSSevdXzqYKSJ8PXB9Ke0bgWhV50J4Ni7jM8PbvypLcMtuMxbsX?=
 =?us-ascii?Q?ZOX2PRgmwyWOd9BD7zaemPnU7KuFqfmSzVAFhKTG6qVzfe01S38+D0LQUdEw?=
 =?us-ascii?Q?Aq45evdbyEM5EPtOuA4LIx7DAtKlDb7KMJsJ/uBhJpXMrI/SSHixgwEpXJX/?=
 =?us-ascii?Q?xCbjFt3LxQtUSE7+N/lDWR3CG5spu0uTMMQxxzdNkiZq8RkXBGBzSLVIuqPq?=
 =?us-ascii?Q?ZdAyQj/rT+rwyQtQwZU2BbPmJNB09fzPYYzVYjOsQhlTC1VuuHn2MFP0oNq0?=
 =?us-ascii?Q?wPCDyY7WQ+3O+GeP75HMwW9ZRo68LP70TZXXRUNtStFiWqSHlQ6XIlCXnz7V?=
 =?us-ascii?Q?F807iVjiKZkd3H2OYS7iSVE/?=
X-OriginatorOrg: f-secure.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e18d805-1304-4ca9-a6c6-08d92a75bb6e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2443.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 12:05:39.5286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5bc339e-b691-425e-9d05-4181afc9e065
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OaQlB5uaZKI57SPJqv5e2rLjcX230phQcg+iLF+6pop/3MQJPbBw2f9elSNU5RKkYb95g5z0F2t3HBKYSB0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2249
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com>:
> The security oriented users of fanotify are anti-virus on-access
> protection engines and those are using mount marks anyway
> (dynamically adding them as far as I know).
> [cc Marko who may be able to shed some light]

(Thanks for the CC; back from vacation.)

Yes.

> For those products, creating a bind mount inside a new mount ns
> may actually escape the on-access policy or the new mount will
> also be marked I am not sure. I suppose cloning mount ns may be
> prohibited by another LSM or something(?).

Not sure I appreciate all dimensions of the problem space, but I don't
immediately foresee overwhelming escaping problems.


Marko
