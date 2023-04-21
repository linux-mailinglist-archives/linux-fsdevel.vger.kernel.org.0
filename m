Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CDD6EACD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjDUO1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjDUO1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:27:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022C1705
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:26:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f6c285d92so286914666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1682087211; x=1684679211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1oaWq3oB7582N+GZbpQzJaSY1l1hDiSvD7AKqVxEKw=;
        b=kkKD2tdh1K4M/DdXw4sj5VMkrMQhqXZfX5rfo4BDwafNS0bYGKRQeH8CO36mzU24DJ
         Hm/rW4w3d32NRjU1/UVFTs/ZBxdCwn5JTWAXBuQw8CrB4At001Zs4qLSbXgfJhX88QzW
         xJ2OjSV7zQgOSs5QMoKtQiZLbP32Uf5vaRcno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087211; x=1684679211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1oaWq3oB7582N+GZbpQzJaSY1l1hDiSvD7AKqVxEKw=;
        b=FRk1qiy6ddIezLIIAmyvWTukUawXtCYiCf5G3T8iT0Q9qXtjSu9tAmVt72Ay2gmr6Z
         pfmNtmYrUAHzO4O6zWBs4QvEX4a4Yt51xh0+nj2nPK4GGtKz0yL/8zADyJ08hDaPITrl
         mRCaFS/wgSLhv2Eq3CTEQ5BUYO/AC8LujZaYkZiom5liaT65jZcTtV/Si8Cs0PiQds7k
         dKj5yeg+PcAfGJoHR6EtGJQeEFaB4ZTmryzgWrkeYgal1oIK5Rn+HK25sw9djNhIvPaR
         x2nRVvJ+1iYbPBLZ/K2EgZMES2zlpJaegpHHaqf8hPAxcQ5mtn7gEhPPgUd5KzdkqztK
         We4A==
X-Gm-Message-State: AAQBX9efusenoXx2O9STfJ8uQb0blERgp7vFzsn3n2y7kFFgMBJjwj0l
        Tv0/xGlvAdofz75g0CZOMqklwedhKz2f5b4N5Uf51g==
X-Google-Smtp-Source: AKy350b1WpMXjTcPv4Pd6KzOIUEFlar62Yi3AsoISHKLwSKZRusLHHg8SM9ua+wnNI6sRvCcMVJb5vkPVRh2z4EcLFk=
X-Received: by 2002:a17:906:9144:b0:94e:8431:4767 with SMTP id
 y4-20020a170906914400b0094e84314767mr2549549ejw.38.1682087210745; Fri, 21 Apr
 2023 07:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
 <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
 <56E6CAAE-FF25-4898-8F9D-048164582E7B@kohlschutter.com> <490c5026-27bd-1126-65dd-2ec975aae94c@eitmlabs.org>
 <CAJfpegt7CMMapxD0W41n2SdwiBn8+B08vsov-iOpD=eQEiPN1w@mail.gmail.com>
 <CALKgVmeaPJj4e9sYP7g+v4hZ7XaHKAm6BUNz14gvaBd=sFCs9Q@mail.gmail.com>
 <CALKgVmdqircMjn+iEuta5a7v5rROmYGXmQ0VJtzcCQnZYbJX6w@mail.gmail.com>
 <CALKgVmfZdVnqMAW81T12sD5ZLTO0fp-oADp-WradW5O=PBjp1Q@mail.gmail.com>
 <CAJfpeguKVzCyUraDQPGw6vdQFfPwTCuZv0JkMxNA69AiRib3kg@mail.gmail.com>
 <CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com>
 <CAJfpegt0rduBcSqSR=XmQ8bd_ws7Qy=4pxVF0_iysfc7wFagQQ@mail.gmail.com>
 <CALKgVmdyQwXcwQHBNEzE7XsCYmqQFeNLXZ5-hTPErjYz4PvgaQ@mail.gmail.com> <CALKgVmeohJVEreXdb1OH3x9VS4O5VMpR+82=QFbk0+95y3xyYA@mail.gmail.com>
In-Reply-To: <CALKgVmeohJVEreXdb1OH3x9VS4O5VMpR+82=QFbk0+95y3xyYA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Apr 2023 16:26:39 +0200
Message-ID: <CAJfpegu1fOwuEs1c_FRdQwYMCiuQMcf-mntJwN9CpTU+J=gr7Q@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     jonathan@eitm.org
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000adb47905f9d972bc"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000adb47905f9d972bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Can you please try out the attached patch?

Thanks,
Miklos


On Wed, 22 Mar 2023 at 19:42, Jonathan Katz <jkatz@eitmlabs.org> wrote:
>
> Confirmed bindfs interaction:
>
> Based on your bindfs comment I redid my configuration as follows:
> ORIGINAL  (FAILS):
>     FS1 - exports "/Data"  (nfs)
>     FS2 - Mounts "/Data", does a bindfs, does an overlay
>
> TEST (SUCCEEDS):
>     FS1 - does a bindfs and exports a series of directories:
>               # bindfs -u 5007, -g 5007 /Data /Data-jiajun
>               /etc/exports:
>                     /Data  machine.org(ro,sync,no_subtree_check)
>                     /Data-jiajun machine.org(ro,fsid=3D12,sync,no_subtree=
_check)
>      FS2 - used to do bindfs to make the lowers, but, now mounts
> "/Data-jiajun" as the lower
>                FS2 then does the overlay and samba share.
>                 It would not let me do the 2nd export if I did not
> include the fsid entry....
>
> WOOT WOOT.
>
>
> Not an ideal solution as I have to make changes to 2 servers in order
> to accomplish my goal :/.
>
>
>
>
>
>
>
>
> On Tue, Mar 14, 2023 at 7:43=E2=80=AFPM Jonathan Katz <jkatz@eitmlabs.org=
> wrote:
> >
> > On Thu, Mar 9, 2023 at 7:31=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> > >
> > > On Tue, 7 Mar 2023 at 18:14, Jonathan Katz <jkatz@eitmlabs.org> wrote=
:
> > > >
> > > > On Tue, Mar 7, 2023 at 12:38=E2=80=AFAM Miklos Szeredi <miklos@szer=
edi.hu> wrote:
> > > > >
> > > > > On Tue, 7 Mar 2023 at 02:12, Jonathan Katz <jkatz@eitmlabs.org> w=
rote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > In pursuing this issue, I downloaded the kernel source to see i=
f I
> > > > > > could debug it further.  In so doing, it looks like Christian's=
 patch
> > > > > > was never committed to the main source tree (sorry if my termin=
ology
> > > > > > is wrong).  This is up to and including the 6.3-rc1.  I could a=
lso
> > > > > > find no mention of the fix in the log.
> > > > > >
> > > > > > I am trying to manually apply this patch now, but, I am wonderi=
ng if
> > > > > > there was some reason that it was not applied (e.g. it introduc=
es some
> > > > > > instability?)?
> > > > >
> > > > > It's fixing the bug in the wrong place, i.e. it's checking for an
> > > > > -ENOSYS return from vfs_fileattr_get(), but that return value is =
not
> > > > > valid at that point.
> > > > >
> > > > > The right way to fix this bug is to prevent -ENOSYS from being
> > > > > returned in the first place.
> > > > >
> > > > > Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") fixes one o=
f
> > > > > those bugs, but of course it's possible that I missed something i=
n
> > > > > that fix.
> > > > >
> > > > > Can you please first verify that an upstream kernel (>v6.0) can a=
lso
> > > > > reproduce this issue?
> > > >
> > > > Got ya.  that makes a lot of sense, thank you.
> > > >
> > > > I have confirmed that I continue to get the error with 6.2 .
> > > > quick summary of the lowerdir:
> > > >    server ---- NFS(ro) ---- > client "/nfs"
> > > >    client "/nfs" --- bindfs(uidmap) --- > client "/lower"
> > >
> > > Can you please run bindfs in debugging mode (-d) and send the
> > > resulting log after reproducing the issue?
> > >
> > > Thanks,
> > > Miklos
> >
> > OUCH -- MY LAST EMAIL WAS REJECTED FOR BEING TOO BIG
> > I HOPE THAT I AM SUMMARIZING THE RELEVANT INFORMATION HERE:
> >
> >
> > Hi Miklos, thank you.... I am sorry for the delay.
> >
> > The log is somewhat long and was sent in a separate email.
> >
> > I broke up the log into entries to try to match the chronology of actio=
ns:
> >    * ENTRY 1 nfs mount the external drive
> >    * ENTRY 2 perform the bind fs
> >    * ENTRY 3 perform the overlay
> >    * ENTRY 4 restart smb
> >    * ENTRY 5 mount the filesystem on a windows box
> >    * ENTRY 6 performing some navigation on the windows file explorer
> >    * ENTRY 7 attempt to open a data file with the windows application.
> >
> > The only place that generated a kernel error in dmesg was at ENTRY 7.
> >
> > Because the logs are so big, I tried to parse them, I may have made a
> > mistake or omitted information -- if you think so, as mentioned, the
> > full bindfs logs were sent separately
> >
> >
> > Here is my attempt to parse out the errors associated with this dmesg e=
ntry:
> >
> > [ 1925.705908] overlayfs: failed to retrieve lower fileattr (8020
> > MeOHH2O RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-163=
2.d/chromatography-data.sqlite,
> > err=3D-38)
> >
> > --
> > unique: 1550, opcode: GETXATTR (22), nodeid: 71, insize: 73, pid: 3458
> > getxattr /eimstims1/deleteme2/8020 MeOHH2O
> > RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chro=
matography-data-pre.sqlite
> > trusted.overlay.metacopy 0
> >    unique: 1550, error: -95 (Operation not supported), outsize: 16
> > --
> > unique: 3922, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
> > getxattr /eimstims1/deleteme2/8020 MeOHH2O
> > RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chro=
matography-data-pre.sqlite
> > system.posix_acl_access 132
> >    unique: 3922, error: -95 (Operation not supported), outsize: 16
> > --
> > unique: 3954, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
> > getxattr /eimstims1/deleteme2/8020 MeOHH2O
> > RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chro=
matography-data-pre.sqlite
> > system.posix_acl_access 132
> >    unique: 3954, error: -95 (Operation not supported), outsize: 16
> > --
> > unique: 3960, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
> > getxattr /eimstims1/deleteme2/8020 MeOHH2O
> > RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chro=
matography-data-pre.sqlite
> > system.posix_acl_access 132
> >    unique: 3960, error: -95 (Operation not supported), outsize: 16
> >
> >
> > Thank you again!
> >
> > -Jonathan

--000000000000adb47905f9d972bc
Content-Type: application/x-patch; 
	name="fuse-ioctl-translate-enosys-in-outarg.patch"
Content-Disposition: attachment; 
	filename="fuse-ioctl-translate-enosys-in-outarg.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lgqn4zjn0>
X-Attachment-Id: f_lgqn4zjn0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGlvY3RsOiB0cmFuc2xhdGUgRU5PU1lTIGluIG91dGFyZwoKRnVzZSBzaG91bGRuJ3QgcmV0dXJu
IEVOT1NZUyBmcm9tIGl0cyBpb2N0bCBpbXBsZW1lbnRhdGlvbi4gSWYgdXNlcnNwYWNlCnJlc3Bv
bmRzIHdpdGggRU5PU1lTIGl0IHNob3VsZCBiZSB0cmFuc2xhdGVkIHRvIEVOT1RUWS4KClRoZXJl
IGFyZSB0d28gd2F5cyB0byByZXR1cm4gYW4gZXJyb3IgZnJvbSB0aGUgSU9DVEwgcmVxdWVzdDoK
CiAtIGZ1c2Vfb3V0X2hlYWRlci5lcnJvcgogLSBmdXNlX2lvY3RsX291dC5yZXN1bHQKCkNvbW1p
dCAwMmMwY2FiOGU3MzQgKCJmdXNlOiBpb2N0bDogdHJhbnNsYXRlIEVOT1NZUyIpIGFscmVhZHkg
Zml4ZWQgdGhpcwppc3N1ZSBmb3IgdGhlIGZpcnN0IGNhc2UsIGJ1dCBtaXNzZWQgdGhlIHNlY29u
ZCBjYXNlLiAgVGhpcyBwYXRjaCBmaXhlcyB0aGUKc2Vjb25kIGNhc2UuCgpSZXBvcnRlZC1ieTog
Sm9uYXRoYW4gS2F0eiA8amthdHpAZWl0bWxhYnMub3JnPgpGaXhlczogMDJjMGNhYjhlNzM0ICgi
ZnVzZTogaW9jdGw6IHRyYW5zbGF0ZSBFTk9TWVMiKQpDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc+ClNpZ25lZC1vZmYtYnk6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgot
LS0KIGZzL2Z1c2UvaW9jdGwuYyB8ICAgMjEgKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCi0tLSBhL2ZzL2Z1c2Uv
aW9jdGwuYworKysgYi9mcy9mdXNlL2lvY3RsLmMKQEAgLTksMTQgKzksMjMgQEAKICNpbmNsdWRl
IDxsaW51eC9jb21wYXQuaD4KICNpbmNsdWRlIDxsaW51eC9maWxlYXR0ci5oPgogCi1zdGF0aWMg
c3NpemVfdCBmdXNlX3NlbmRfaW9jdGwoc3RydWN0IGZ1c2VfbW91bnQgKmZtLCBzdHJ1Y3QgZnVz
ZV9hcmdzICphcmdzKQorc3RhdGljIHNzaXplX3QgZnVzZV9zZW5kX2lvY3RsKHN0cnVjdCBmdXNl
X21vdW50ICpmbSwgc3RydWN0IGZ1c2VfYXJncyAqYXJncywKKwkJCSAgICAgICBzdHJ1Y3QgZnVz
ZV9pb2N0bF9vdXQgKm91dGFyZykKIHsKLQlzc2l6ZV90IHJldCA9IGZ1c2Vfc2ltcGxlX3JlcXVl
c3QoZm0sIGFyZ3MpOworCXNzaXplX3QgcmV0OworCisJYXJncy0+b3V0X2FyZ3NbMF0uc2l6ZSA9
IHNpemVvZihvdXRhcmcpOworCWFyZ3MtPm91dF9hcmdzWzBdLnZhbHVlID0gJm91dGFyZzsKKwor
CXJldCA9IGZ1c2Vfc2ltcGxlX3JlcXVlc3QoZm0sIGFyZ3MpOwogCiAJLyogVHJhbnNsYXRlIEVO
T1NZUywgd2hpY2ggc2hvdWxkbid0IGJlIHJldHVybmVkIGZyb20gZnMgKi8KIAlpZiAocmV0ID09
IC1FTk9TWVMpCiAJCXJldCA9IC1FTk9UVFk7CiAKKwlpZiAocmV0ID49IDAgJiYgb3V0YXJnLT5y
ZXN1bHQgPT0gLUVOT1NZUykKKwkJb3V0YXJnLT5yZXN1bHQgPSAtRU5PVFRZOworCiAJcmV0dXJu
IHJldDsKIH0KIApAQCAtMjY0LDEzICsyNzMsMTEgQEAgbG9uZyBmdXNlX2RvX2lvY3RsKHN0cnVj
dCBmaWxlICpmaWxlLCB1bgogCX0KIAogCWFwLmFyZ3Mub3V0X251bWFyZ3MgPSAyOwotCWFwLmFy
Z3Mub3V0X2FyZ3NbMF0uc2l6ZSA9IHNpemVvZihvdXRhcmcpOwotCWFwLmFyZ3Mub3V0X2FyZ3Nb
MF0udmFsdWUgPSAmb3V0YXJnOwogCWFwLmFyZ3Mub3V0X2FyZ3NbMV0uc2l6ZSA9IG91dF9zaXpl
OwogCWFwLmFyZ3Mub3V0X3BhZ2VzID0gdHJ1ZTsKIAlhcC5hcmdzLm91dF9hcmd2YXIgPSB0cnVl
OwogCi0JdHJhbnNmZXJyZWQgPSBmdXNlX3NlbmRfaW9jdGwoZm0sICZhcC5hcmdzKTsKKwl0cmFu
c2ZlcnJlZCA9IGZ1c2Vfc2VuZF9pb2N0bChmbSwgJmFwLmFyZ3MsICZvdXRhcmcpOwogCWVyciA9
IHRyYW5zZmVycmVkOwogCWlmICh0cmFuc2ZlcnJlZCA8IDApCiAJCWdvdG8gb3V0OwpAQCAtMzk5
LDEyICs0MDYsMTAgQEAgc3RhdGljIGludCBmdXNlX3ByaXZfaW9jdGwoc3RydWN0IGlub2RlCiAJ
YXJncy5pbl9hcmdzWzFdLnNpemUgPSBpbmFyZy5pbl9zaXplOwogCWFyZ3MuaW5fYXJnc1sxXS52
YWx1ZSA9IHB0cjsKIAlhcmdzLm91dF9udW1hcmdzID0gMjsKLQlhcmdzLm91dF9hcmdzWzBdLnNp
emUgPSBzaXplb2Yob3V0YXJnKTsKLQlhcmdzLm91dF9hcmdzWzBdLnZhbHVlID0gJm91dGFyZzsK
IAlhcmdzLm91dF9hcmdzWzFdLnNpemUgPSBpbmFyZy5vdXRfc2l6ZTsKIAlhcmdzLm91dF9hcmdz
WzFdLnZhbHVlID0gcHRyOwogCi0JZXJyID0gZnVzZV9zZW5kX2lvY3RsKGZtLCAmYXJncyk7CisJ
ZXJyID0gZnVzZV9zZW5kX2lvY3RsKGZtLCAmYXJncywgJm91dGFyZyk7CiAJaWYgKCFlcnIpIHsK
IAkJaWYgKG91dGFyZy5yZXN1bHQgPCAwKQogCQkJZXJyID0gb3V0YXJnLnJlc3VsdDsK
--000000000000adb47905f9d972bc--
