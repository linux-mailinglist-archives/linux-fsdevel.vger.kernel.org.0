Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B96E1AC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 05:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDND2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 23:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjDND2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:28:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2126.outbound.protection.outlook.com [40.107.101.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7930C7;
        Thu, 13 Apr 2023 20:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM19QIvSfSzMU1C2W6Wws8dLKIgPniUyAS4JYxZYp9Oi/RKjrCWFzWglQ1F3MYw9mj1Zpg0vdb2Cq+MiRZ81OtR/vn/wvKdb6yv80is8RqN+e8ioaF4uaoPlFdhTtb9WJR4pPyXmB0RZMJjz782JKp+gmvYnsZB6qO+gOOOFJN5xu1+8MDm0lSTlkqsaInEPZQbJLYgUK2lZOtu55A/qZYYLm+MQa5XiLQu0IIwgYEbh6UYDBCBpcFY4ZLm/VZwZlDcDycxkmvECYIaBz13VZFqrPpLs7HvD6QoiwjrOO3AUczb1A3I6bjE/MCNGhkorzL+BRW3H2JXm3p/Jiq6slw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8xv5Ye17TDjcvAj7QcN5IfMNHaX5h6ENVHlroCtDHI=;
 b=msK1FKa7Zs0vH7MZk7JOksZKXXLOFVBVYjrm7THPcs/AvOkk1M4ZpbtsMoPL9lHjtIAEYhy1S3+/QH/6iphXdWwe0Ymjvsi1jMh+D3UnRT063tYY0HXrS/yj0rGm9ol8loqTBxIS9Ba570i/Tt9rUn8a/o07F38hQNXTAUBE49MhcB2GPY4QOhTsCNI83T6X896/rGHI/x/66rBphWhTOAq4K+F7sJkPDLxzqylQShHm+ef3qRrl1DXOFWatDt4ZUVapsBdgWcqAvXxD6n0FR+FKaEWmgCfHDvnXtIpds7a6YaeBejhrVTrYavoMOaebtGHeisIC8IX+ILi14nLtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8xv5Ye17TDjcvAj7QcN5IfMNHaX5h6ENVHlroCtDHI=;
 b=VEUcr8DyE6woD2jC0twvkezPrgP29vmvlS49ikkKhhoSxGXQgheKJuO0kenVSD2rSBIU2I/VMk0oc0WBWvXCvWqQLajBSU9zfiD2E2O8bRvlgcCL3EkPj84+CTGnXYF4ILwfkK3lE3PLH/O5wCkztBqoQav9L0Cc0h5Ft9blF1U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4608.namprd13.prod.outlook.com (2603:10b6:5:3aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 03:28:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 03:28:45 +0000
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
Thread-Index: AQHZblNqsf7f4dFF3kOaw1n+rBD0gK8p1WaAgABDqACAAAytAA==
Date:   Fri, 14 Apr 2023 03:28:45 +0000
Message-ID: <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
In-Reply-To: <20230414024312.GF3390869@ZenIV>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4608:EE_
x-ms-office365-filtering-correlation-id: 0ecd17d0-b082-48d9-9fef-08db3c985a56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L63uB+7sd2jWeuLTkQphFbTXRVlT6lrd5ZQbv+KieBon/gm92ortJ9mXhXbGheCKeq1yqBtQ7s9rgpIDKhVsEn34JynerAy0ldn+zEzEu8QRljbZGCguUQKEQuu0Z03AVDLKIUZoe/FwJpfaKQftr9TzNyR1bRnqQcNKY0J0HsMD/liziCVfwDkSmu3zzZqlHofeXnah+/os+BkmUwq4te1gI7mC8gLHa4Sx2EbuR7VmnlPCPQcQ9EHeQx6qKn9okQSttSvSmM0UX2TBEAZgmQqn4zY88xmQumfo9LOnVuq4p7RzFhszmLnzOB2s7yoz+5vlNZSddf3V72RENcqaxmKDDaa4SrtQU3Otba2Rm9kzify5y7tnUmH0mNNszoM8q6f0Od1j1Yfg2ojrJL5WXzOzjPlhyUokAXyOlkh3W3/zMmvagTEYD/pEAmjnYHGmo+w9YCkr9gn2VrwCW3zbXTyIsE7VVy/FIHWtTlc9A/YNHRlDc82gq3u3tPGVC2SzDxT5KMunswmel20wS1+y+dfK4jUfwiyWBVEIjlUIoq9h8L4XHRsbXOOofbNVuW/Doq4NHufFwKl+AKe5Dilp9j+JRWYFnrFgkVqtPsy2SYrKkm2XjEGfNv3+JGDWWEWy6XmUjMCEoglFxgXZ0jzfUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(376002)(39840400004)(451199021)(478600001)(316002)(54906003)(83380400001)(2616005)(6506007)(26005)(71200400001)(6486002)(66946007)(64756008)(6512007)(66476007)(76116006)(66446008)(41300700001)(53546011)(6916009)(4326008)(186003)(5660300002)(2906002)(38100700002)(38070700005)(8676002)(122000001)(8936002)(33656002)(66556008)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tVUaDL9Qg6njGR+7o4hUJZI05HrF/neH3LNRDwPt7NLSXmpljaMp1Mew997D?=
 =?us-ascii?Q?zGk0+AIQw1RnJgF8r6bfyEk2BfsJUqpJKnY6D+ZcBAR8FHyt5fd9j8xu2oLi?=
 =?us-ascii?Q?Hb1OKiaRru9XcZU+VwTMw4vrmYzCb5384FU20bnJZO5/BoN6eoztWtyYaBUs?=
 =?us-ascii?Q?r6W1Xxahwr7NuOEmC7hGbsKI3RqZvKi6y5poW4jK/Y1BEQM5TpFhSW6HmeKD?=
 =?us-ascii?Q?si/rc9/PRDmPggw92luKO7MMeKZUP8m+8XX+fBpLPS4fIn3sbaxRFtPuqY1V?=
 =?us-ascii?Q?BTpW8kqhX+Lsh/faaltg5Ddgdgi8BvgEjLrFy/tUk0kpGoB2mnkSlQi3WSqu?=
 =?us-ascii?Q?d5bqzdvLKYkPeSSEICTjNKMIYYXVfErAb+kMqxppzhdOpkUVhJyGpUkV5+VE?=
 =?us-ascii?Q?la5ZH2G4viiuGH++AcA4zic1HsKvAW8rcdThWfr2R8J7tes0IrfVYgjZWSZK?=
 =?us-ascii?Q?JjFDRIDp8iRoZAq3KPfu7Tb6etFrnsvKLHiNUEHcrqOqhZiylW2a5puXfbqa?=
 =?us-ascii?Q?nWRbYOeZeBHBgr48iPToNkYGZM4NX5mdzrtuTJvEeDNCXUp3n0kyPWxcSDQi?=
 =?us-ascii?Q?csx1Cz/XUcmMws4B0n0gksE/uvoN3ZrcdkAhDBL0cOqtV9H1/NVsSsjNq0Co?=
 =?us-ascii?Q?ukQfQ7oWg0voIiUT5NWoz68+256Ce54/t/0DsIpCPuDAiHACTV0VS2G1Dac/?=
 =?us-ascii?Q?2KZDiHTENnP6h/ZvwyBgcKSQwL1lb2oCWSRG0A6Rsh9McAb1+5z+iWZx5PEk?=
 =?us-ascii?Q?vxNF72VaBavzotN5dQs/f1G67uxePcDfYqjKJ9z/iKWa720Py0xsgWtusE/o?=
 =?us-ascii?Q?Pa8lCVqI6dAjEqN3iOW9uPKgPrdAsfalmZpe1ewz1pU7gtGZ+twv55VfZAxD?=
 =?us-ascii?Q?etAtEezzqrIeYAKt4C5HZqDh10lc0hJCqe7LMDBftY+OfW42IyCTSPWHingc?=
 =?us-ascii?Q?HXocNN7/2/EFfh8scD9p0NMK+INr8Z+YCI8foiAmE+nRNIQrDsjR9BOlFOwk?=
 =?us-ascii?Q?Tq6nXZxJeK7z580MdT/rau6YgIjLU+cdJ7BSda8CJm0syQBBpYwhsyW8sAkO?=
 =?us-ascii?Q?w51Sh1MZcnE8B+m+OqMcF9Y8jN33979pT/i9qOCYrAAPR7qw+srVxFPbXZtY?=
 =?us-ascii?Q?6n4DAeTqHFVk4thDDMxUEDbTP56Vpmtxro/DwGbXSGbqlblmFiq7bjCn7iGJ?=
 =?us-ascii?Q?LrIgudz+lA7SX39WK9urRawD58EJppRUWpaqAwAz7gkUtXC9HzjvitOYEILY?=
 =?us-ascii?Q?CxF/+NsgNMGzFWhcmScPH25lWRtW4I0+n+P2ara8Dg/gQSLKaCRDNmU/w5KH?=
 =?us-ascii?Q?2StynCVlO10qK884hYprzV9ZS2thTMf/fO9mlPEZX8yjW2/d7Z6jsWdv0fju?=
 =?us-ascii?Q?gDcAvhiEi062w5Obrn7tsswR9Zls3tthE8HrGdpk2cwCvDS3d5s20QGGO374?=
 =?us-ascii?Q?I6oNNFEOr629/OTw9s955ajs64p9a0yH7obKWofv2qA3cNostF6E1C1Xrtjc?=
 =?us-ascii?Q?ApZMeH8MFk8cDag8uv/BLfhWz0FVhBFJWnG/92MtTk6iizZ2X//DTkDkl07n?=
 =?us-ascii?Q?zxDU8+yPc32dtwfEL9o/y77AWBrS7T+MnBQiEUbTypriuImNXKD2MbVKPR8D?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20FF64F935CD8A4EA4FE5795345E2984@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecd17d0-b082-48d9-9fef-08db3c985a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 03:28:45.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUFfB8i+MToR2lZjIf60j/Tm38ozWb3EtF9Nl0xgtj/SQkKpGsnUpsS5h+NKSGXyvVihIdv25LJiDVdkZ0Z8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 13, 2023, at 22:43, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>=20
> On Fri, Apr 14, 2023 at 08:41:03AM +1000, NeilBrown wrote:
>=20
>> The path name that appears in /proc/mounts is the key that must be used
>> to find and unmount a filesystem.  When you do that "find"ing you are
>> not looking up a name in a filesystem, you are looking up a key in the
>> mount table.
>=20
> No.  The path name in /proc/mounts is *NOT* a key - it's a best-effort
> attempt to describe the mountpoint.  Pathname resolution does not work
> in terms of "the longest prefix is found and we handle the rest within
> that filesystem".
>=20
>> We could, instead, create an api that is given a mount-id (first number
>> in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
>> read /proc/self/mountinfo, find the mount-id, and unmount it - all
>> without ever doing path name lookup in the traditional sense.
>>=20
>> But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
>> LOOKUP_CACHED, and it only finds paths that are in the dcache, never
>> revalidates, at most performs simple permission checks based on cached
>> content.
>=20
> umount /proc/self/fd/42/barf/something
>=20
> Discuss.
>=20
> OTON, umount-by-mount-id is an interesting idea, but we'll need to decide
> what would the right permissions be for it.
>=20
> But please, lose the "mount table is a mapping from path prefix to filesy=
stem"
> notion - it really, really is not.  IIRC, there are systems that work tha=
t way,
> but it's nowhere near the semantics used by any Unices, all variants of L=
inux
> included.

We already have support for directory file descriptors when mounting with m=
ove_mount(). Why not add a umountat() with similar support for the unmount =
side?
Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE privileg=
e to convert the mount-id into an O_PATH file descriptor.


_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

