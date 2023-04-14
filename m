Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF886E270E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDNPb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDNPb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:31:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60528D30C;
        Fri, 14 Apr 2023 08:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIb3n9FzQbyZ5ScQfmL3WPOoBl+h/vpB0xqREboW5X+c0s8ptyWfwjFipvVbhLk8yDW8TAGN26PrAezC1W5ZbspDGBvykXYI/qLH8N64CK8OnAahHFxQAI7qoSUJY2sJ1z9KvzD3Hn+DFfbT5TH3sLzap4BNxJ3xuLTlNvwZEF0zWCt6Tyvho+/Pvn17w2maggLYyR3halvJYVoJEdETKFInzJSayltOmoQw1QIvfDReYhQELleENrRXP3sG4KnA6+o5qPgoSJqdGm6rKzHK1zdOmqsg+e2DlO2Vhm7Fw4EVmEpKPVX/Zq8yqtrywwF3AFP+u8BPPBIAF2exJqMkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NKwwwtZEpVB1W2qw+krTszAPZM8kM1HGGopdvDTeAI=;
 b=FvzzXfl5qZAf3iK6zLzCPhOVcL3uqs97jj1QeDx77W203gA1rbzDDPJDaTt7kZs/cPovft5RurNfBDnL2DpIjvuj4AfopxTSOBgxRGHd4e6a5N4lY9jtzbhsHtSTBtRNHTWm48IS9p555awN91C6L6oA6HxX2+yFz7InzlesrAHcKa+MIXz/mGZ+TVCvqVbDA433ijOKNLlmPqNwIuJrP5oEmKJkj1nw0LMkxudoul9S7s8Cq2MfoeQfhgZTTBHfg2ToWAe1bX4PpJt8ZX1mkLyfnzz/nondus3F4Xcpsn5r1ZjmExS/YZH3WndqpVahsTtFkCkyGFRVGjo8wL80pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NKwwwtZEpVB1W2qw+krTszAPZM8kM1HGGopdvDTeAI=;
 b=LShcy3GAZ2khWvUgDQYe22KYjA7aS6u5NABSQvgimnU2mkonRchJNeBxfDpq9UBi1MGDEt/K4xupR40AUiRFa/n5Dmxu9M35DLmZDCoS5Vuy3DvGYb21RXLl3tdU3tdehC/e7p1Hup6KmmEiiR2LX0JmSW1gryrlfnAKq2+A1F8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB5776.namprd13.prod.outlook.com (2603:10b6:806:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:30:31 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 15:30:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeffrey Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Thread-Topic: allowing for a completely cached umount(2) pathwalk
Thread-Index: AQHZblNqsf7f4dFF3kOaw1n+rBD0gK8p1WaAgABDqACAAHvlAIAAO+cAgAALHwCAAA6aAIAABNEA
Date:   Fri, 14 Apr 2023 15:30:30 +0000
Message-ID: <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
 <20230414-leiht-lektion-18f5a7a38306@brauner>
In-Reply-To: <20230414-leiht-lektion-18f5a7a38306@brauner>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN4PR13MB5776:EE_
x-ms-office365-filtering-correlation-id: 52294cc2-cf7c-408f-fa7d-08db3cfd2e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdYK7xmOCmQ/ivyeAevoUfIk4h2oY2jZMCNmtAjGyWm0UoEsaZFdRJZmP4yKWTkHVC52rGa2Cl0zPFS1uHmFjYPJCWBqWhWuMbw5LX61TkUmhGab7UuMui5Gzb8VrDbtqhQezqrymeRlXfFmU1j5hzqL28YPypR3uuZyTb6YMHSKHau+j+DZGcFp9WYhb7ulFMWzNpuFlUarnfjWg8fflSoI7M21CAW68tetLI+rbDoDYj/cNH5e4k4en85fb+WZPiQPZUBRpRPYJUM11HFMfNDcIoV3aAWc7qwnLXVuSoLTfx5rd9g7P5bV0ybVok/CxELZRAqBPiv08VRm0mC9sL2VXVo1WtmRFcCLAFGzvTfqNLpP5ptav4WjHp/hSNYAWVxaev1RjTAgFdaM9x2IsRP2Lsi2yICf2/4raqatNwymrPk/K+c1FfBDZIVGAlgRgSadek4YTG9c1VvkBAJsHdWQv/POgk6W8jYEP7xsC9y930zAMx61WDNUF/nuDTrI4yt6adUpGrVro2ltn3sKvHoadcASm4SJaRoHEJlIvKKvULNdky7wMyrNJOoINSR36Za+VktQU+6O5Tobo9ZoOmExpa4lWLimhjjBPAaCKOXHK45yZ0S2Qdiw//IzWkKvbG35YsXOfVF411L07dFRsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39840400004)(376002)(346002)(396003)(451199021)(316002)(4326008)(38100700002)(6916009)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(5660300002)(41300700001)(2616005)(71200400001)(36756003)(86362001)(6486002)(54906003)(26005)(186003)(6512007)(53546011)(6506007)(38070700005)(2906002)(83380400001)(8676002)(8936002)(33656002)(478600001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bPOurPPLPKQiBcmMJXa/VEwISqBFVRmfxAxuRcmbsZJgJLkDLo/bbOKfz0qw?=
 =?us-ascii?Q?UW3ph3N76wmdwl/yr5oHFWfiYr60tNtUSKAUG5fTkuTXAg8q+Kj6PY/LjSWr?=
 =?us-ascii?Q?Y6+jmX9IG3R2OI9rwuUpj0yugrv3WerODZp9VWbLqBOlns5tMFD35X7Hm0uV?=
 =?us-ascii?Q?fi8rY9olnDXwYkmuY7qM8dvc0tThgqUNc2yVTE4+8lPGlf5MMbVy1jrUAb/7?=
 =?us-ascii?Q?PsWEK6aYvvocqx7ztTp4+DyGl8vgunzSmlH/x8znpJWMKz//bxa/3Ve2d+mp?=
 =?us-ascii?Q?Y48j/yBSR7GUAcHhda0uzbffkO010iOul4tmUblBMEW7GgcWo4mggAF275Bv?=
 =?us-ascii?Q?t4krTeeXA+Mdq/tRu7DAp6BgLYVn1mrS7WqJdvMVIiwoZYbi0XaNJIbzqn0L?=
 =?us-ascii?Q?2CqjUZCCisVv+wwXkK9GlI/iqIBX5VPAVptkl9QRief90bfGYMni7JTSYPpR?=
 =?us-ascii?Q?rqVz3rlgf/+ePI6qW2Bx/P+ucoxAqPXf/Nz+cKVZhZbVoZpY1pMfUWK0EYci?=
 =?us-ascii?Q?o2NKITy8/8cHZHHv5VNThwcmxW1H5OSsuzkJ7jMmIBpP88GAWolzk7ZboyhI?=
 =?us-ascii?Q?WiCHnXhwZldzcQCPjL7gaCiSSN862SBNJ9hvAOOSX6lFTdr69U8GPN2RYYmq?=
 =?us-ascii?Q?2leUheqReHMOZrKVGmcP62Ep4IFHZL3ZHl/2tu9/ncUBLyQ/cPA6B6hare8N?=
 =?us-ascii?Q?MLsIFAJRFwB6/1OVRoq/0SCh5H0FJnHyhke+qDYRClXxDUxgZDr46++r9nKy?=
 =?us-ascii?Q?OCYLP7dsHZC7iNDI88UBzgR3O1EURB7OMSx4kawrrbGlHDuGhUari0fWuCVG?=
 =?us-ascii?Q?7L7CuF7QvjQIsJ71luO2j7OuMwDxEl+y7oFTWFliLwumfoWiyJnHoH0rdUpl?=
 =?us-ascii?Q?MpvdRgWbeBMrd4mKtgsbmwfxWI5UNfntuApzziYRIGgIvkoJIubpcwvlLmJT?=
 =?us-ascii?Q?EnO90W8MnXpxBwP6IvgflUpJn5/+RUTt0Ep3nxxKmgehBmqk/KKIWfjT0frz?=
 =?us-ascii?Q?ISMEMnOJElBe3WqnUJoo+iUsTj9yIrNEWP6jtzKujkkoveDiwHjcyGqrj3PL?=
 =?us-ascii?Q?x6pQm8qVRfwW05FgQq2TFYgYJ3+YD0eH2dGWlSZuDToAL62ylg5GQjaEL255?=
 =?us-ascii?Q?XrOhK8Iq2Dp+tTYiwMOWGlXdogXko2DPIleLl88gTPVXHLhb1Esurg36/lwj?=
 =?us-ascii?Q?18rDJqHAYyomPpdHdsklRRQWkPEtYmFDk+VMhhDKxbCtBG0t7LZuqIsyAseu?=
 =?us-ascii?Q?wBBDl6b/2QDtkfluDsFqqFjbm/Gm9/ZJYjM28wqFilJTEgr8HcQT8w5WyxC8?=
 =?us-ascii?Q?nO7M3yS+KTq+ReRYIKg4A87SvTxznRTPuaZIE16YKJI3lXU12nynZe501MB8?=
 =?us-ascii?Q?lWNqy0e/RzwlS6kRkDL417j41To8CGxNRFuOsqKAbdE78XT4JrdqhfvIycnZ?=
 =?us-ascii?Q?JDzAo0na2BU3QK+HS6n+a04SySGxJVhwSvaqhpKtypmqHgaC+ehEzQESikL6?=
 =?us-ascii?Q?8wIu0OZu1WVOKhOI90nJbLH7Hewz+gasqO8lfL0T10NDCPuhM4ghB69nrbus?=
 =?us-ascii?Q?ybCZ7fXFIKZUND7s1DNMuAR0KrYggcn+4P8eQTY785swPglhPGSrXCEYcppv?=
 =?us-ascii?Q?Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B78E3F532B9E694997BEB4192EAAF735@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52294cc2-cf7c-408f-fa7d-08db3cfd2e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 15:30:30.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCulS5eycIXVlQRTYHI32n848KknZPSp2QHBxk53/Pyp5PjZs3/DBfZbKQaeLyc/aSQ2bYBN1NFYWlMyRPIdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5776
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 14, 2023, at 11:13, Christian Brauner <brauner@kernel.org> wrote:
>=20
> On Fri, Apr 14, 2023 at 02:21:00PM +0000, Trond Myklebust wrote:
>>=20
>>=20
>>> On Apr 14, 2023, at 09:41, Christian Brauner <brauner@kernel.org> wrote=
:
>>>=20
>>> On Fri, Apr 14, 2023 at 06:06:38AM -0400, Jeff Layton wrote:
>>>> On Fri, 2023-04-14 at 03:43 +0100, Al Viro wrote:
>>>>> On Fri, Apr 14, 2023 at 08:41:03AM +1000, NeilBrown wrote:
>>>>>=20
>>>>>> The path name that appears in /proc/mounts is the key that must be u=
sed
>>>>>> to find and unmount a filesystem.  When you do that "find"ing you ar=
e
>>>>>> not looking up a name in a filesystem, you are looking up a key in t=
he
>>>>>> mount table.
>>>>>=20
>>>>> No.  The path name in /proc/mounts is *NOT* a key - it's a best-effor=
t
>>>>> attempt to describe the mountpoint.  Pathname resolution does not wor=
k
>>>>> in terms of "the longest prefix is found and we handle the rest withi=
n
>>>>> that filesystem".
>>>>>=20
>>>>>> We could, instead, create an api that is given a mount-id (first num=
ber
>>>>>> in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
>>>>>> read /proc/self/mountinfo, find the mount-id, and unmount it - all
>>>>>> without ever doing path name lookup in the traditional sense.
>>>>>>=20
>>>>>> But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
>>>>>> LOOKUP_CACHED, and it only finds paths that are in the dcache, never
>>>>>> revalidates, at most performs simple permission checks based on cach=
ed
>>>>>> content.
>>>>>=20
>>>>> umount /proc/self/fd/42/barf/something
>>>>>=20
>>>>=20
>>>> Does any of that involve talking to the server? I don't necessarily se=
e
>>>> a problem with doing the above. If "something" is in cache then that
>>>> should still work.
>>>>=20
>>>> The main idea here is that we want to avoid communicating with the
>>>> backing store during the umount(2) pathwalk.
>>>>=20
>>>>> Discuss.
>>>>>=20
>>>>> OTON, umount-by-mount-id is an interesting idea, but we'll need to de=
cide
>>>>> what would the right permissions be for it.
>>>>>=20
>>>>> But please, lose the "mount table is a mapping from path prefix to fi=
lesystem"
>>>>> notion - it really, really is not.  IIRC, there are systems that work=
 that way,
>>>>> but it's nowhere near the semantics used by any Unices, all variants =
of Linux
>>>>> included.
>>>>=20
>>>> I'm not opposed to something by umount-by-mount-id either. All of this
>>>> seems like something that should probably rely on CAP_SYS_ADMIN.
>>>=20
>>> The permission model needs to account for the fact that mount ids are
>>> global and as such you could in principle unmount any mount in any moun=
t
>>> namespace. IOW, you can circumvent lookup restrictions completely.
>>>=20
>>> So we could resolve the mnt-id to an FMODE_PATH and then very roughly
>>> with no claim to solving everything:
>>>=20
>>> may_umount_by_mnt_id(struct path *opath)
>>> {
>>> struct path root;
>>> bool reachable;
>>>=20
>>> // caller in principle able to circumvent lookup restrictions
>>>       if (!may_cap_dac_readsearch())
>>> return false;
>>>=20
>>> // caller can mount in their mountns
>>> if (!may_mount())
>>> return false;
>>>=20
>>> // target mount and caller in the same mountns
>>> if (!check_mnt())
>>> return false;
>>>=20
>>> // caller could in principle reach mount from it's root
>>> get_fs_root(current->fs, &root);
>>>       reachable =3D is_path_reachable(real_mount(opath->mnt), opath->de=
ntry, &root);
>>> path_put(&root);
>>>=20
>>> return reachable;
>>> }
>>>=20
>>> However, that still means that we have laxer restrictions on unmounting
>>> by mount-id then on unmount with lookup as for lookup just having
>>> CAP_DAC_READ_SEARCH isn't enough. Usually - at least for filesytems
>>> without custom permission handlers - we also establish that the inode
>>> can be mapped into the caller's idmapping.
>>>=20
>>> So that would mean that unmounting by mount-id would allow you to
>>> unmount mounts in cases where you wouldn't with umount. That might be
>>> fine though as that's ultimately the goal here in a way.
>>>=20
>>> One could also see a very useful feature in this where you require
>>> capable(CAP_DAC_READ_SEARCH) and capable(CAP_SYS_ADMIN) and then allow
>>> unmounting any mount in the system by mount-id. This would obviously be
>>> very useful for privileged service managers but I haven't thought this
>>> Through.
>>=20
>> That is exactly why having a separate syscall to do the lookup of the mo=
unt-id is good: it provides separation of privilege.
>>=20
>> The conversion of mount-id to an O_PATH file descriptor is just akin to =
a path lookup, so only needs CAP_DAC_READ_SEARCH (since you require privile=
ge only to bypass the ACL directory read and lookup restrictions). The resu=
lting O_PATH file descriptor has no special properties that require any fur=
ther privilege.
>>=20
>> Then use that resulting file descriptor for the umount, which normally r=
equires CAP_SYS_ADMIN.
>=20
> There's a difference between unmounting directly by providing a mount id
> and getting an O_PATH file descriptor from a mnt-id. If you can simply
> unmount by mount-id it's useful for users that have CAP_DAC_READ_SEARCH
> in a container. Without it you likely need to require
> capable(CAP_DAC_READ_SEARCH) aka system level privileges just like
> open_to_handle_at() which makes this interface way less generic and
> usable. Otherwise you'd be able to get an O_PATH fd to something that
> you wouldn't be able to access through normal path lookup.


Being able to convert into an O_PATH descriptor gives you more options than=
 just unmounting. It should allow you to syncfs() before unmounting. It sho=
uld allow you to call open_tree() so you can manipulate the filesystem that=
 is no longer accessible by path walk (e.g. so you can bind it elsewhere or=
 move it).

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

