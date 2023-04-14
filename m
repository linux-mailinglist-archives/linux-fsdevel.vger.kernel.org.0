Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39356E2580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNOVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDNOVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:21:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE94F2;
        Fri, 14 Apr 2023 07:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYuy1H95Lr7pEwzZKXgTyohUOEIJhsxV6UmkXUOB/O6705qmbqETF8Qg2nP2pZtlNVQuSlvxilhcxfGsC9w+mAO3y0tpmfWhkWELZ+PKKlAHpo8Ji83RaS7J8G+5l/GRxh2FycfWn8ItBCGqABjaevfoZLGkupkRWyXi52MZulzKhN47doHTJxZZpHdKjHM1QWLwCTh63zHwDLOMEvo7WemlsPm1k0C6M/g/BvR6uEjOdmQ5WMfzEPdyrqwJ3oxZYn/ssil1EOVNslH/kybQppFxHVmNQ+Q+Y2SclZJK3PMcJtfsigB8JsFBVFgJ/XFfZ69TsX5ZBGMJUklLGoKP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtfvpAjRVLXREya7a1p9YxfyvVjGCpyVcl68pfkbYUQ=;
 b=I28kw5oyILXpX8kP6wM70NNYiM5OUJmhtlcNfiuEDjudgbLPyUGwSeCzpBojU8kLURoL3QPnURNStF8s0ig4zoz4cypJBK8WReyNMg2FkiFbKu+Rnp2ISH8jmVbT+OVX2Ihm4kqHUmXxYnB4C3abL5zw2s7omsd50Xg0d+7r4x3ADVChhM6lI8XaVQsujordd0x1uICKnEH/j3lfTTkn7saJLYjvvy+eR1/1fcZoWrGvIJ2qNMOaNaNEOHxET7EEpK+FLAY/E1DUWJT10c3hdlsWPgVctD5Hu50Y7cHBBmTB0xjXlisQyrJz3uL6J87+bt+mdct0zM/TiXdcEcScGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtfvpAjRVLXREya7a1p9YxfyvVjGCpyVcl68pfkbYUQ=;
 b=SsoSuFilI+hHKUtA0TgDC3zNmHXd/Rs1NxwvRBiBmKN1RWLNkzO7us6oAhhAB7XdKwC5Yy748qemBP2CD47CZv/3C1rIrhuNpuls+EJ6hb9nFamjX605ndHRmVL0r0MKISMrXDORoaCl16VObu09STgI3iLEef6xEOo5rvnjYfU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4712.namprd13.prod.outlook.com (2603:10b6:408:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 14:21:01 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 14:21:01 +0000
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
Thread-Index: AQHZblNqsf7f4dFF3kOaw1n+rBD0gK8p1WaAgABDqACAAHvlAIAAO+cAgAALHwA=
Date:   Fri, 14 Apr 2023 14:21:00 +0000
Message-ID: <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
In-Reply-To: <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4712:EE_
x-ms-office365-filtering-correlation-id: 00e6b783-86fa-4b53-8469-08db3cf37909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nD5KEXH6ks2ws1eBTqKOCj79KfkwDKSUZwklRYu6AfCdYrVAsnKJsmgWVbs8l6ifjHq7EzabdLlbsKAP5+BlboN1tiwwRkeoZoGkglZyUWa/yIHhCB2W7dDQ7RaYwh2TCMYrT3B231ykFmmPJQ7x2kflXj+BQk745e65rdOTI4QY/ZMINluHB92COdVBCb73B4mEBpEPsuNW2EwyL6Abb6RX7D3K/yjgv4k05l6emW0tWCd2HcXWRm3kPLIUr25y6+aV8P8oQqn7/ga2/mFP3dy65GN+7jyJRM0Hvwj7yZLhxDPt7S/wwIIrP4pKUgWWR/utN7FtiHtVjat/2hwH/vOxS5g+cDVzU85/1JXxPuKBTxPxAOdhCfgBTvrqDx5v7MxZqrI8nWGgxHMZVb/GWWBducEK8TJuXiJ/pllv3T2YcbOWhAxwrob7lBaQvGCPTDrT3HSV5QWDq8H6cY516Oh+6ibKKyJ131o1WkT0316xNU5KF/FNYffFNp5SClzxMy2K4w0/vuQpEwnMZQ+buIjETrB5aiTlx/Xs7arkWfkF+RqcpSLKWOlqCKykd0zGHYwJGwipTemrjPseBqwO2MBrMfJ89EyIBkQF4t5SjPIf8vjI3vjU8zmk1GRqqnUis+JmzVqsEIdXDSGcuT02Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39840400004)(451199021)(86362001)(54906003)(316002)(478600001)(33656002)(41300700001)(122000001)(8936002)(38100700002)(8676002)(5660300002)(66476007)(64756008)(76116006)(66446008)(66556008)(53546011)(6512007)(6506007)(36756003)(38070700005)(26005)(186003)(66946007)(4326008)(6916009)(83380400001)(71200400001)(2906002)(6486002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?laZVNv+SpfuHULRptt8d0D2VrMvsc39sOl860AICSQjOm985adjuKG+SIS7S?=
 =?us-ascii?Q?I18WyEhTyCCY9Omta63kcjrEBvmFnPaGLgvRQDml0KGdBSf/k4cvXsy+TDhA?=
 =?us-ascii?Q?wii1tstgpxw9k55iBfercI57dpZq9O9txoE7juIWWKYcgkrFGB2Mpbmsnols?=
 =?us-ascii?Q?1GB8LFLRncq8QXsnnUrH6xbYMxxYg82GVU1MdHV9+kYlTVl4b5G3fO0Kew9f?=
 =?us-ascii?Q?ooXtfRS5Ke12gauDDsQ1ArVPHyupVpj5eqCi4OjhoJjfFGRT2Sxso66pI1fT?=
 =?us-ascii?Q?MVL3H7iTWI1JcK9oyP/qZJZXKstJakHTMesMLY6AKdFOvOhaATi4B/NuJ4QX?=
 =?us-ascii?Q?coze9rsQ90KhFcbHmFwM7bnH+58xHimy4LugQ+OVnT4DTGRCX+d22tQop+zU?=
 =?us-ascii?Q?MX9+XPMA7hkm4kflLErrwvyPkpbbiXqOTxqjtQ8smXchWfcnbMYGwY79NH5H?=
 =?us-ascii?Q?4Y4mbZ3EY7Ooz8EzEjX/6J161IOSN1YFTHHJbKX2kGuxpIUM0wzJFv21Xu0O?=
 =?us-ascii?Q?nAk2cQrlqtkN1B1SbG+2QIN0wIHHUrTpzEpyoAKUUqDIqREuZUDSVqOWFd1m?=
 =?us-ascii?Q?6ibBwIB3G9Au5l0emXrfQc3F84Z27Fxhu8cu9Wi4sIRpCsAQRO6PPAT5aebA?=
 =?us-ascii?Q?0Unqf8OTjFt1OoasjA5OB76mZ1c0KU8H8j0xa+WFh32qdiOdLZdTHTnhJi6L?=
 =?us-ascii?Q?K5/K1mqdrwCpb7uqMIddL3M5MGot9RSthB0rUNLf6d9S//u9BcTSfWmxNgiD?=
 =?us-ascii?Q?hEfIFnzy+cw5To/0x22waGjL522UEVblEvg7GUKqSXrG2+JGXv4gjPykqlB8?=
 =?us-ascii?Q?yB5VqlRexKKkZJCZkQYQsMc1uWdq5kX1iYe///E1sfQ/w6lLCAjJM+W9kDdI?=
 =?us-ascii?Q?/+f1Ml6lRZojwO8Bnrm6EJ1/LIAio5/HntXbQJB1DKhZ2nsYG8DvWj2dj80m?=
 =?us-ascii?Q?NtRVJzY8wpeTH0pUMomhKZRsAY25mJuI1yLsva1qHg18VqasldSIyZNcY5+e?=
 =?us-ascii?Q?38waQMkhUMfUvPrEi42KpP7UUkI1izcuGoskrBmBBaG1qpn2x0zeJrDH6RHA?=
 =?us-ascii?Q?Uch6XXJg7jZMLVBSR6NRsYlm1yGmriFj3O3Hd6GgN7VfZ91GdVuvqSRTgr0M?=
 =?us-ascii?Q?4tsundSimK3QD479qUcgZpNX8N/i50xA75eu58+hUL70QYcgLB3yMNozRDpG?=
 =?us-ascii?Q?xaGq5x21ca+yz9GpCXhq3xq4rhrBvfsE6f1yM+132XCs5YV38SWWu8G2Wp9q?=
 =?us-ascii?Q?HiQ2JOlu+XJXxOhSR8OOrkR4kvn2lrKa44nxCDC/WR6v4ii7WZNsBv1ER4rk?=
 =?us-ascii?Q?VlS7haleKtDJBMbIDUSgD1/HVhfQ5hPpDYGU2YX114qjFsXJ2+VXkmDkkVrq?=
 =?us-ascii?Q?A5A83wGhSX/v6KZdSkGkgduUBv0xQSU1hPJHzBAzTEKytk0gLET4FZozZEWU?=
 =?us-ascii?Q?o5qvOHM9Htoht5QioXn0MZ+e8LW4kZIkEazl1DCNaFFM4JYLbB1g2ptdtf6e?=
 =?us-ascii?Q?5mwvh6l5lSkHU9zu8nZsaX5qg3rC2qOa7IsHWqTJLSmS/offq3M6TUsgtbzT?=
 =?us-ascii?Q?rEFcotsacM+NX0W1f1udl+V618fctdUHMn89Vak5V0tl3Ck6sb9Yv2UkaTBI?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0D20E1B05163D4C9A11D832AEB8524C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e6b783-86fa-4b53-8469-08db3cf37909
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 14:21:00.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewOqh/VP/KMsvQXHUHo+QJUBaKpfGe8x4g8ztqjjyzdkV8gAXu3VIvMhEUwJJCC6S/3lj99srCUmVDUIR2IqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 14, 2023, at 09:41, Christian Brauner <brauner@kernel.org> wrote:
>=20
> On Fri, Apr 14, 2023 at 06:06:38AM -0400, Jeff Layton wrote:
>> On Fri, 2023-04-14 at 03:43 +0100, Al Viro wrote:
>>> On Fri, Apr 14, 2023 at 08:41:03AM +1000, NeilBrown wrote:
>>>=20
>>>> The path name that appears in /proc/mounts is the key that must be use=
d
>>>> to find and unmount a filesystem.  When you do that "find"ing you are
>>>> not looking up a name in a filesystem, you are looking up a key in the
>>>> mount table.
>>>=20
>>> No.  The path name in /proc/mounts is *NOT* a key - it's a best-effort
>>> attempt to describe the mountpoint.  Pathname resolution does not work
>>> in terms of "the longest prefix is found and we handle the rest within
>>> that filesystem".
>>>=20
>>>> We could, instead, create an api that is given a mount-id (first numbe=
r
>>>> in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
>>>> read /proc/self/mountinfo, find the mount-id, and unmount it - all
>>>> without ever doing path name lookup in the traditional sense.
>>>>=20
>>>> But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
>>>> LOOKUP_CACHED, and it only finds paths that are in the dcache, never
>>>> revalidates, at most performs simple permission checks based on cached
>>>> content.
>>>=20
>>> umount /proc/self/fd/42/barf/something
>>>=20
>>=20
>> Does any of that involve talking to the server? I don't necessarily see
>> a problem with doing the above. If "something" is in cache then that
>> should still work.
>>=20
>> The main idea here is that we want to avoid communicating with the
>> backing store during the umount(2) pathwalk.
>>=20
>>> Discuss.
>>>=20
>>> OTON, umount-by-mount-id is an interesting idea, but we'll need to deci=
de
>>> what would the right permissions be for it.
>>>=20
>>> But please, lose the "mount table is a mapping from path prefix to file=
system"
>>> notion - it really, really is not.  IIRC, there are systems that work t=
hat way,
>>> but it's nowhere near the semantics used by any Unices, all variants of=
 Linux
>>> included.
>>=20
>> I'm not opposed to something by umount-by-mount-id either. All of this
>> seems like something that should probably rely on CAP_SYS_ADMIN.
>=20
> The permission model needs to account for the fact that mount ids are
> global and as such you could in principle unmount any mount in any mount
> namespace. IOW, you can circumvent lookup restrictions completely.
>=20
> So we could resolve the mnt-id to an FMODE_PATH and then very roughly
> with no claim to solving everything:
>=20
> may_umount_by_mnt_id(struct path *opath)
> {
> struct path root;
> bool reachable;
>=20
> // caller in principle able to circumvent lookup restrictions
>        if (!may_cap_dac_readsearch())
> return false;
>=20
> // caller can mount in their mountns
> if (!may_mount())
> return false;
>=20
> // target mount and caller in the same mountns
> if (!check_mnt())
> return false;
>=20
> // caller could in principle reach mount from it's root
> get_fs_root(current->fs, &root);
>        reachable =3D is_path_reachable(real_mount(opath->mnt), opath->den=
try, &root);
> path_put(&root);
>=20
> return reachable;
> }
>=20
> However, that still means that we have laxer restrictions on unmounting
> by mount-id then on unmount with lookup as for lookup just having
> CAP_DAC_READ_SEARCH isn't enough. Usually - at least for filesytems
> without custom permission handlers - we also establish that the inode
> can be mapped into the caller's idmapping.
>=20
> So that would mean that unmounting by mount-id would allow you to
> unmount mounts in cases where you wouldn't with umount. That might be
> fine though as that's ultimately the goal here in a way.
>=20
> One could also see a very useful feature in this where you require
> capable(CAP_DAC_READ_SEARCH) and capable(CAP_SYS_ADMIN) and then allow
> unmounting any mount in the system by mount-id. This would obviously be
> very useful for privileged service managers but I haven't thought this
> Through.

That is exactly why having a separate syscall to do the lookup of the mount=
-id is good: it provides separation of privilege.

The conversion of mount-id to an O_PATH file descriptor is just akin to a p=
ath lookup, so only needs CAP_DAC_READ_SEARCH (since you require privilege =
only to bypass the ACL directory read and lookup restrictions). The resulti=
ng O_PATH file descriptor has no special properties that require any furthe=
r privilege.

Then use that resulting file descriptor for the umount, which normally requ=
ires CAP_SYS_ADMIN.

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

