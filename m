Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06646E1AF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 06:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDNEGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 00:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNEGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:06:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2129.outbound.protection.outlook.com [40.107.96.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF54EEA;
        Thu, 13 Apr 2023 21:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIktrh4L8KABLIn0TmNhF38ITNAeidpDh9dG3rYCsFKI9dSZyUTaNhbZBealvOXhqotuY1izCbjElsamg0Nk0ZY4/eQRiEiULCyq60zCbJXFjj7+z3hTU7JwemDwG6UN4leDgUNVBaYm3aFAGZXPnKm/FTHmw8C4NMJznEO1uNY+GajuKH6knX1CErYqSnyzfBOn3DLOOoYQ09Hsz4cgEu1kS75e0Pr+dcW8CWKW2FxHddJ5xvetfai1ZKSw19QXJRaHdUDFkkYjROrsP3dz5iD7dojVHkQQliYFRnvcpJo6lUzBnJFTYUhSEhNL41MvhtnmVCSXnqzt5iwVo9yHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNjE6Bps4spmPLkZOhwIiqEzMnkLNXrLk5rmAZStvyM=;
 b=cwc4zE2CR9d75v6v5gjPP07ctsMtK2B7V0wYNtkZEMeBZs8lbkpD9TbUEY4lXw7USv60M1Y7mQUW1mRcq8wRDmX59wbOuJEbSQkhJML8P4ooQFFsPz4PGs8cDz/Na7CmGC57cbJjfJvgsVN8sGZuvW2NcrY7MFk6we1irMS6AvoeOdUZ/39+ZfaGSTNRhGupbBGKwb7wnM0151DjD/viEZnkmugP48Q2CQcJCAr0rEAtLHs+YtgbgUbSLEBMlIBTlTca6sjkVb226P8zTYvUxajtCICQYVSscTm+kiNStb2JdB5sz6FOy9VO7W7Wyn4URIymGAyqvGNG1qurLkzv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNjE6Bps4spmPLkZOhwIiqEzMnkLNXrLk5rmAZStvyM=;
 b=A7oXfwnxDqsAXZ2zJksnqwQX51ozbe33+aslgJ9+0L4dLpkTLyFhQejfArNkh/30ZMBRN857IffzWLxLzWu8ga3LyLZQuREg7N2Bmt1bxOw1HhOV+Yj3BLD7J6NuVZmMrqfdO2WDdwhFh7y5cHeyaXbdSlpxILBEBx+32EwpPNM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB4798.namprd13.prod.outlook.com (2603:10b6:806:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 04:06:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 04:06:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Alexander Viro <viro@ZenIV.linux.org.uk>
CC:     Neil Brown <neilb@suse.de>, Jeffrey Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Thread-Topic: allowing for a completely cached umount(2) pathwalk
Thread-Index: AQHZblNqsf7f4dFF3kOaw1n+rBD0gK8p1WaAgABDqACAAAytAIAABkkAgAAEJIA=
Date:   Fri, 14 Apr 2023 04:06:03 +0000
Message-ID: <93A5B3C4-0E20-4531-9B65-0D24C092CE70@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
 <20230414035104.GH3390869@ZenIV>
In-Reply-To: <20230414035104.GH3390869@ZenIV>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB4798:EE_
x-ms-office365-filtering-correlation-id: 35073876-65a2-46ee-69e1-08db3c9d90bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/Mgu/v2B8w/HguHSksjbijhm8C7mB+GBblZr1BFR2GiMO5iJESUutUAQWtflXE5/FgrcJxNFWZoAKd045guMy8zdXyqbvC0xhC/Ps+7sAJhk+WQHM9l0oJPnVbEM/lCtydsyR2fOLxm0rTiUjQCtFJQkBaLYVKJJxKTFTv1pNi2QiXKbdpQ1C30Dhx0zJDQjTjWMxho8uOPgACE7SDiXDPyKpNq5lGCicHMKzZWrwHJxwUEduzD+RL/p67gRnJoBZ7fR+cFwQjSR/7PU4iuZH6FfZAFtI4BJuOAiPki2xJj2NDgUbSql8a9rxnWPdNEyPxIRkgvSO3HcoUslI95vLfVXS2VqkFzQ0pjnT4dX+DXpAEntVmfFSsRs6Iz/+HlOAJA+JCdA+XdCkQR7YicKW06Gq6h1nvUTQqd3PTlke1GT4jS8DRbM+u8BzSQVd7kP7m28+Jt+kQY0NY5P6EPlvFT3sTJVqaQGHsfpx4NolrkpTXz6vPOjNfnTPeq6QnCt5pnt66/vSl1EgNLXwCVkrEYNtCmMt3pNvzMwC+Y0G6OdBbgTVp9sp5SsiIAdg+dnxUKZmCvNUSVs0VBnAhNCZV+nKXQsMkTId0H0WG2M3uMr7D4ZYpWkEMJ+3H1vk1/sszk+F3wGISYRCtfkek8zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39840400004)(346002)(396003)(451199021)(33656002)(316002)(41300700001)(122000001)(26005)(6512007)(53546011)(38070700005)(6486002)(6506007)(186003)(38100700002)(86362001)(71200400001)(2616005)(66446008)(36756003)(83380400001)(66476007)(66556008)(66946007)(64756008)(4326008)(6916009)(54906003)(8676002)(76116006)(8936002)(5660300002)(2906002)(4744005)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jwdWkMG0+KE7jR2vsmjLSigwIHChJoN4lnzjlEb4uOgh2Y4kB8eRhyRlzJO9?=
 =?us-ascii?Q?fuSVgkd6bvqDlt92kJl98O3c2gwTlCsRMPkQRiaQAHqBAfUwvP6C0UekleHb?=
 =?us-ascii?Q?Gipjsd2qKFE+CaxlxNdXJnoHpYFky+K9bWkpisY0968uuRQOtCluY0mKCS5F?=
 =?us-ascii?Q?tH/nNPYNcBud8qaZ/aHxl5cs1GWqe98LKUqIUxZrQsnY7MUPEPZOiSCtulBT?=
 =?us-ascii?Q?kKtn/9/KQzGphvqh3Op82Vrihv1oEUzuWNCOtc+iuoaX4XmRyjdvnTZW1VVw?=
 =?us-ascii?Q?7HYih/Hg0tRBKKbfOG8iMdddrRVnXXTPwcicQaooo1VEFrqJXRoFfLI5rEUL?=
 =?us-ascii?Q?onam2ss4xVLRKl9NWX+SZj2QIFzHwsattryz0w/e41MAQuqizP0cFfmUSr+L?=
 =?us-ascii?Q?MZEQ3atkRA+0EdIbZjOMQJxPt0svbf/BuAqt1JEn3HLFOyAvTiSV/9KZP4b4?=
 =?us-ascii?Q?7kmb7ETKaoFCWiWe0+n3/CEC2PskQ82tjXi4yYmqdhWv0rxxbkdeGJFwfaOv?=
 =?us-ascii?Q?DHC2im6SqMaaGhjLTche922YVwpa8yAQ+7+8x0mRmEhqmuAkdk1TC6ri3HUo?=
 =?us-ascii?Q?D49+W+TfSAsPxUeSNsjMy7pL048MWGyX/JxcyHc0JvQWr8ip6jz8XVyRyrDR?=
 =?us-ascii?Q?PtOYpxHqzPS1AG+soZxtMG/gWplPzoW2rIQYnwneDUh9jqzHbYqgBmPcGK30?=
 =?us-ascii?Q?I+PGYiWXNB3XALfA4aG7+Lh4+AgCcs69iPJeWnT7IGhZngP6+VIYeTTR4Sud?=
 =?us-ascii?Q?2I4WvTp+OAgEC6ZlqG5Hoo3NKxMIULitG1XVubXrByyzX9yy5dbIpBMbALsI?=
 =?us-ascii?Q?QlIxUAhqZyV6hIOkLLWW24wjn7usZZI1UlVgquVEdkUTzGy9rdLVuW4Didim?=
 =?us-ascii?Q?6PuSeejXDMVA4KaD2NRK/m+fzYyfmGqUcOqExkaO9HXeQqd6XeEwPVS6V/qX?=
 =?us-ascii?Q?eLuR8GDWAO/07EPsuOG1dBzhTLwzOVLAy7FfC5md5TkUVINJA+pNRsQoxn/M?=
 =?us-ascii?Q?QIRr9yR/UF+WWGzZcrrT+xZSG8awOfOr1c5ZzkAvmacaFFiZjNaUYO3nCFNZ?=
 =?us-ascii?Q?S5ckAeb2AQiqe/BbAROVJorEe4XhHNKk3Ija3EBAmYvuyOqoT83vlCeGlFjy?=
 =?us-ascii?Q?s/T/auuDlMogn6yOcqfAh/70w4lL6M/PzFD0Isr9XNJXPZoXFt/hKMNY3NAE?=
 =?us-ascii?Q?QhrZrOijo+jlgoqHvpl6beuPJwFhU2EHjwjAmQvs1+0pjo7fjAaR4Lf0IwMo?=
 =?us-ascii?Q?EDhfiIzL86w1BBvv5zot/TTWxQEWjt+l1YjDcK/xoHe+6h593QgqDUYQac0/?=
 =?us-ascii?Q?wP99aboBA4LIiJCrH14CtcwTk4zDKRScuSyd12Wl4oOShX2mVA/O+8x/7iqj?=
 =?us-ascii?Q?A+s6QAiJAzKP8vLpg/aj6m0bDT3pQAtTn/b25xLUKU0nYLb8Oqki1uGOrRlg?=
 =?us-ascii?Q?psZxjywYbhEFp9lT4X08t8wj0Budwtj690JIsMB9RJGMZIMkVRyI/GgP7fuK?=
 =?us-ascii?Q?xkSSfXCV1XOToRF6Y4d04Ux1oT0TR1kPobTMFNdIAEKUav6uV2SBXZDFDPXW?=
 =?us-ascii?Q?lHob477iibOzZRSw1TwiUnepJ02sBn2PI5rWy84J7hvhGupqxJ0tXfTFLatU?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4DA17B1C875CB644B59E19437925DD1C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35073876-65a2-46ee-69e1-08db3c9d90bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 04:06:03.8414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aycJ20slsWQbylqgthSKazs3yLFoGt0cp7UXF3kWEkWe0N9HJArfewo9OayEvSexRLrQ/MuGBFN01fpfF+xc3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 13, 2023, at 23:51, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>=20
> On Fri, Apr 14, 2023 at 03:28:45AM +0000, Trond Myklebust wrote:
>=20
>> We already have support for directory file descriptors when mounting wit=
h move_mount(). Why not add a umountat() with similar support for the unmou=
nt side?
>> Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE privi=
lege to convert the mount-id into an O_PATH file descriptor.
>=20
> You can already do umount -l /proc/self/fd/69 if you have a descriptor.
> Converting mount-id to O_PATH... might be an interesting idea.

A dedicated umountat() might avoid the need for the lazy flag, if it were a=
llowed to close the descriptor on success for the special case of an empty =
path.

Looking more closely, it would seem that CAP_DAC_READ_SEARCH might be a suf=
ficient privilege requirement for the mount-id -> O_PATH syscall.

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

