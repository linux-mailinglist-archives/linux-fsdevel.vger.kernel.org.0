Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B872CAD6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbgLAUeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:34:24 -0500
Received: from mail-mw2nam12on2127.outbound.protection.outlook.com ([40.107.244.127]:37344
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387643AbgLAUeX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:34:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3rUhSdoh05y+kaYnvAJg2lGKR9BrfHsqM34wzsM7iFvdw7wBTfH86lRL7mJL4wVvGsQi+tWaZU2VZMlo3+AX8RL8c7ty7epzvgiTI/qx8CJKMzlgvO4NoeloN8OITKrXKBgHbCUtnhHbMNGwlFKDDwwH9zSnCmfgpZpnJILeluvtkA7FHH7h0o9JeH3c+FwdVHMtIJk00/x3qhvsv7vDSIb5Am0fTMHRCzEJtE9JDgUzP6OeOw20bYZcrjuGex0dAYQVeJxgTemdnaeZHePNfnAwoixifjSxbVvFNjZi29tL7Y5CBWkYNtAEJCTq2CDs3vKhJwJ9/dKkvQX88gLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OdbvpkuKXzbWKPhrMMgBjY515wtZudD7C0fEUX97m0=;
 b=OyK+gkfWAIEUAL5OGEJAXTkWd1V6C2lWbG/LB21YDfGZDWdLS7D3wcBN1ZtzS1pOG/MCKF8uL2scvPoEk1lv4cFKikUCl8m8osfuCwVNomLNQyoBN/jIjc9OZ79eHYQeBbGSRaKdl0WiWpgaYa8z7BQperlFkmwfYLmW0fX2YdMv3h8y+K6ML0kSjkb/aoSGBg5+mNiiQyY1k2Z0Wt83G1XeFaWl3rP7GDSGDlvwWJnnFP5ydJzSqvM3Fi2JlY46X6iYfShPEGxYgpkcEbnd/q93Enb2myvIgee7v20h4muDHz55jeJ0D7rYXX2FokqdyYHTVjxamlQsgRYY2Fn54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OdbvpkuKXzbWKPhrMMgBjY515wtZudD7C0fEUX97m0=;
 b=JMrSUi/35+1AaPRztkH7hIrr+q3EDNlyiLyg3FQdUTIZSxmSUcCR4PHH4uriTKsvW+lr2u29rOJJPb/QpL7qxF1Qk0Y2ExaMbiCkifMFeaXfgMFgpSi6VqwquMcGPjUvWeS/NPTIb5Yd9owqFUXO+f4cjvyyrDSgoNq2uwLq0wk=
Received: from BY5PR22MB2052.namprd22.prod.outlook.com (2603:10b6:a03:235::12)
 by SJ0PR22MB2704.namprd22.prod.outlook.com (2603:10b6:a03:319::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 20:33:35 +0000
Received: from BY5PR22MB2052.namprd22.prod.outlook.com
 ([fe80::5c47:73c9:d7c:f1b4]) by BY5PR22MB2052.namprd22.prod.outlook.com
 ([fe80::5c47:73c9:d7c:f1b4%8]) with mapi id 15.20.3632.017; Tue, 1 Dec 2020
 20:33:35 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Race: data race between ext4_setattr() and acl_permission_check()
Thread-Topic: Race: data race between ext4_setattr() and
 acl_permission_check()
Thread-Index: AQHWx0H4DHIsMrBl00eyuNlS7THY8Kng/WQAgAG2kgA=
Date:   Tue, 1 Dec 2020 20:33:34 +0000
Message-ID: <7A506A46-674A-4A88-BAAC-32DA0A49180D@purdue.edu>
References: <051AF232-4255-42B3-95AE-F8F64D66A6ED@purdue.edu>
 <20201130182352.GH5364@mit.edu>
In-Reply-To: <20201130182352.GH5364@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bd99d82-47d4-4a45-2541-08d896386051
x-ms-traffictypediagnostic: SJ0PR22MB2704:
x-microsoft-antispam-prvs: <SJ0PR22MB270418AA8D4C7C4BDF3E7B31DFF40@SJ0PR22MB2704.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwh9I3j160sgJ808iwthRPAKvieVdVIcT08j7s5DH3yvYmOenw6iIjPLdEXTsL4KUxmjKIsAulyerCLwMCpIE5nYf0gEm9uT/gdKJwwNBvo5bIDrGponpKcZZ/nar66IY8A0lwHw9DqB2/nRazOCfN8N4cVTf7rh9j8d+hsDLkcTkCVeUe+buBNP+dy2lvBtU2HMrhtHl+NGMTGWrbeK8pSrdIvAC4kItGdBXhEFC+bYr1v47KR8lUZqAZkk7pj+BkXwDVP2/+ebYoYrKPvUuiGXH3pjG6KnCBPQMPphQ7xS2uyUAJ4wE4P/kx4jV5QM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR22MB2052.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(83380400001)(2616005)(86362001)(6486002)(75432002)(33656002)(71200400001)(786003)(36756003)(316002)(5660300002)(54906003)(8936002)(26005)(8676002)(53546011)(66476007)(6506007)(66946007)(478600001)(6916009)(186003)(4326008)(66556008)(66446008)(64756008)(6512007)(2906002)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2Wq2/VtT56oj10pjU9LKubYvKjJbXm9+IIAO+pfMXTbo0LBAt+KK+KEt7q4r?=
 =?us-ascii?Q?P8xtEAy8MStL8tk2/LE2vuWtyGBqDxWz1uuOS10ACQLBsHnvHVBbN85Yhqil?=
 =?us-ascii?Q?Zw2WQC8m6VZ9tsN0ygxi7BdFDVBlEukUSbaygNrru9LWKAkmrBi96O7G/pDB?=
 =?us-ascii?Q?uIMBSzepd/a8Fbb5/jk4yUIV5MYX3U2R28WpA1cWkfkI1YjMin/FfhjH7lZB?=
 =?us-ascii?Q?zZz9Zad3MIZ9PbNIqKHiFdmloJMlbqE3VMGk+Q8tRNsXodfWc8c3FwlfBrMe?=
 =?us-ascii?Q?HjDMi3zci2dZejYKnQBFAEnY9JnK5I9HBcOqF/8hLBMwNZ7ZAootgUvvRJ2l?=
 =?us-ascii?Q?hG7pYx1WjvUItVu9biYmAJUdXAyYSEKeFFEpvWkjsdv86bUn/YISgt5s0mdb?=
 =?us-ascii?Q?dALJjno7UVIJ13Ump867c9GQD/X5kKuM/m1at32X9yf+d2rwnY0RsQFQQqSu?=
 =?us-ascii?Q?dIFOq3ZQ3Z0YgIam9x8aNw6RqCPnuGIPPIKBrdOx6Y8QJuAs/VPy/999jgwZ?=
 =?us-ascii?Q?iL3UfL4IhyjWutF3fL8bqUMiQGEd2JVbaW4h5h0kQOoYE2jIMguM4WeDPwPJ?=
 =?us-ascii?Q?N8/FSpMyCRMjM7wXgTpRBdl8efYqv4gLoCOqZYKsgQPHOaNqiIbqB9BFRPiP?=
 =?us-ascii?Q?C0Kp97OCAPKwwxIYypWKwxOJqZQOAnVG80z/+c0Pj5EEaG41KwMZMYlpMgcP?=
 =?us-ascii?Q?gw41GBT5xC/u78difVy55jjRnJpugprd6mQhE4bPZqxuHXWUN4Y3NV/0MUMM?=
 =?us-ascii?Q?YrYkvfZyopD0zEm6gyB8V11tbz39ISZW+7NQwWagxRqBg+b6Dj87zm2gh56X?=
 =?us-ascii?Q?Z0QLLLkcpaTkZH3e99Vt9rnzWc3b0ujuENlcvCY8Ydcyr75KZSw9qAKHdFv+?=
 =?us-ascii?Q?e6T/EPwrGOPhEZ9iIHD+O3acpEv69W1dfT9NJOIZ+H3umqjdudL+PBLtcyjA?=
 =?us-ascii?Q?eMwEwFFVoBDx4/tFALTy37YPTeR/JMBMnc5r8d10lgxD/OH7g/uAmCiV0vGU?=
 =?us-ascii?Q?4Ohh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8162948A1215E746B25D5AE0212F3FFE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR22MB2052.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd99d82-47d4-4a45-2541-08d896386051
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 20:33:34.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFzTQCPK0DWPKA9QjUz/jitH0cZHUFlKY0XvdRrgXd+sjscO8cVfSw771loLn9ZymVyqEan01asbvfXTTiAgqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB2704
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your feedback and we really value your opinion. Our project aims=
 at finding rare data races quickly so diagnosing is not yet in our scope f=
or now, but it definitely shouldn't be an excuse. We did some further analy=
sis and we would like to report it as well. Hope this could be helpful.


------------------------------------------
Interleaving
We observed two different interleavings of two instructions, as illustrated=
 below.

Interleaving 1
Writer							Reader
							if (in_group_p(inode->i_gid))
							// read value =3D 0 (initial value)
inode->i_gid =3D attr->ia_gid
// write value =3D=3D 0xee00
...=09
							if ((mask & ~mode & (MAY_READ | MAY_WRITE | MAY_EXEC)) =3D=3D 0)
return 0;

Interleaving 2
Writer							Reader
inode->i_gid =3D attr->ia_gid
// write value =3D=3D 0xee00
							if (in_group_p(inode->i_gid))
							// read value =3D 0xee00		=09
							...
							if ((mask & ~mode & (MAY_READ | MAY_WRITE | MAY_EXEC)) =3D=3D 0)
return 0;

However, in both cases, the function acl_permission_check() returns will va=
lue 0, so we were not able to find any explicit impact it may have. If this=
 attribute is lock-free semantically, then it should be fine.


In fact, we also found another writer site that could race with the reader.=
 We noticed that both two writers are protected so we were curious about th=
e reader.=20
------------------------------------------
Another writer
/tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/attr.c:185
        165   * @inode:  the inode to be updated
        166   * @attr:   the new attributes
        167   *
        168   * setattr_copy must be called with i_mutex held.
        169   *
        170   * setattr_copy updates the inode's metadata with that specifi=
ed
        171   * in attr. Noticeably missing is inode size update, which is =
more complex
        172   * as it requires pagecache updates.
        173   *
        174   * The inode is not marked as dirty after this operation. The =
rationale is
        175   * that for "simple" filesystems, the struct inode is the inod=
e storage.
        176   * The caller is free to mark the inode dirty afterwards if ne=
eded.
        177   */
        178  void setattr_copy(struct inode *inode, const struct iattr *att=
r)
        179  {
        180      unsigned int ia_valid =3D attr->ia_valid;
        181
        182      if (ia_valid & ATTR_UID)
        183          inode->i_uid =3D attr->ia_uid;
        184      if (ia_valid & ATTR_GID)
 =3D=3D>    185          inode->i_gid =3D attr->ia_gid;
        186      if (ia_valid & ATTR_ATIME)
        187          inode->i_atime =3D timespec64_trunc(attr->ia_atime,
        188                            inode->i_sb->s_time_gran);
        189      if (ia_valid & ATTR_MTIME)
        190          inode->i_mtime =3D timespec64_trunc(attr->ia_mtime,
        191                            inode->i_sb->s_time_gran);
        192      if (ia_valid & ATTR_CTIME)
        193          inode->i_ctime =3D timespec64_trunc(attr->ia_ctime,
        194                            inode->i_sb->s_time_gran);
        195      if (ia_valid & ATTR_MODE) {
        196          umode_t mode =3D attr->ia_mode;
        197
        198          if (!in_group_p(inode->i_gid) &&
        199              !capable_wrt_inode_uidgid(inode, CAP_FSETID))
        200              mode &=3D ~S_ISGID;
        201          inode->i_mode =3D mode;
        202      }
        203  }

	=09
Thanks,
Sishuai

> On Nov 30, 2020, at 1:23 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Mon, Nov 30, 2020 at 05:55:20PM +0000, Gong, Sishuai wrote:
>> Hi,
>>=20
>> We found a data race in linux kernel 5.3.11 that we are able to
>> reproduce in x86 under specific interleavings. Currently, we are not
>> sure about the consequence of this race so we would like to confirm
>> with the community if this can be a harmful bug.
>=20
> What do you mean by "data race" in this context?  If you have one
> process setting a file's group id, while another process is trying to
> open that same file and that open is depending on the process's group
> access vs the file's group id, the open might succeed or fail
> depending on whether the chgrp(2) is executed before or after the
> open(2).
>=20
> I could see data race if in some other context of the file open, the
> group id is read, and so the group id might be inconsistent during the
> course of operating on a particular system call.  In which case, we
> might need to cache the group id value, or take some kind of lock,
> etc.
>=20
> But if your automated tool can't distinguish whether or not this is
> the case, I'll gently suggest that it's not particuarly useful....
> Maybe this is something that should be the subject of further
> research?  The whole point of automated tools, after all, is to save
> developers' time.  And not asking them to chase down potential
> questions like "so is this real or not"?
>=20
> Cheers,
>=20
> 					- Ted
>=20
>>=20
>> ------------------------------------------
>> Writer site
>>=20
>> /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/ext4/inode.c:5599
>>       5579              error =3D PTR_ERR(handle);
>>       5580              goto err_out;
>>       5581          }
>>       5582
>>       5583          /* dquot_transfer() calls back ext4_get_inode_usage(=
) which
>>       5584           * counts xattr inode references.
>>       5585           */
>>       5586          down_read(&EXT4_I(inode)->xattr_sem);
>>       5587          error =3D dquot_transfer(inode, attr);
>>       5588          up_read(&EXT4_I(inode)->xattr_sem);
>>       5589
>>       5590          if (error) {
>>       5591              ext4_journal_stop(handle);
>>       5592              return error;
>>       5593          }
>>       5594          /* Update corresponding info in inode so that everyt=
hing is in
>>       5595           * one transaction */
>>       5596          if (attr->ia_valid & ATTR_UID)
>>       5597              inode->i_uid =3D attr->ia_uid;
>>       5598          if (attr->ia_valid & ATTR_GID)
>> =3D=3D>   5599              inode->i_gid =3D attr->ia_gid;
>>       5600          error =3D ext4_mark_inode_dirty(handle, inode);
>>       5601          ext4_journal_stop(handle);
>>       5602      }
>>       5603
>>       5604      if (attr->ia_valid & ATTR_SIZE) {
>>       5605          handle_t *handle;
>>       5606          loff_t oldsize =3D inode->i_size;
>>       5607          int shrink =3D (attr->ia_size < inode->i_size);
>>       5608
>>       5609          if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS=
))) {
>>       5610              struct ext4_sb_info *sbi =3D EXT4_SB(inode->i_sb=
);
>>       5611
>>       5612              if (attr->ia_size > sbi->s_bitmap_maxbytes)
>>       5613                  return -EFBIG;
>>       5614          }
>>       5615          if (!S_ISREG(inode->i_mode))
>>       5616              return -EINVAL;
>>       5617
>>       5618          if (IS_I_VERSION(inode) && attr->ia_size !=3D inode-=
>i_size)
>>       5619              inode_inc_iversion(inode);
>>=20
>> ------------------------------------------
>> Reader site
>>=20
>> /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/namei.c:306
>>        286
>>        287      return -EAGAIN;
>>        288  }
>>        289
>>        290  /*
>>        291   * This does the basic permission checking
>>        292   */
>>        293  static int acl_permission_check(struct inode *inode, int mas=
k)
>>        294  {
>>        295      unsigned int mode =3D inode->i_mode;
>>        296
>>        297      if (likely(uid_eq(current_fsuid(), inode->i_uid)))
>>        298          mode >>=3D 6;
>>        299      else {
>>        300          if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
>>        301              int error =3D check_acl(inode, mask);
>>        302              if (error !=3D -EAGAIN)
>>        303                  return error;
>>        304          }
>>        305
>> =3D=3D>    306          if (in_group_p(inode->i_gid))
>>        307              mode >>=3D 3;
>>        308      }
>>        309
>>        310      /*
>>        311       * If the DACs are ok we don't need any capability check=
.
>>        312       */
>>        313      if ((mask & ~mode & (MAY_READ | MAY_WRITE | MAY_EXEC)) =
=3D=3D 0)
>>        314          return 0;
>>        315      return -EACCES;
>>        316  }
>>        317
>> ------------------------------------------
>> Writer calling trace
>>=20
>> - do_fchownat
>> -- chown_common
>> --- notify_change
>>=20
>> ------------------------------------------
>> Reader calling trace
>>=20
>> - do_execve
>> -- __do_execve_file
>> --- do_open_execat
>> ---- do_filp_open
>> ----- path_openat
>> ------ link_path_walk
>> ------- inode_permission
>> -------- generic_permission
>>=20
>>=20
>>=20
>> Thanks,
>> Sishuai
>>=20

