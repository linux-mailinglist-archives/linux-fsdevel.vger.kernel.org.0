Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8E79EDB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjIMPxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIMPxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:53:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A28CCD
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:53:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401187f8071so234105e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694620406; x=1695225206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbpgIZY0S+jrnQeTU9MHb5yuccFEI2qq5nwURR5Z7vY=;
        b=sxYmXU2lIBjYAH7eyGQ7Hq0KSDiSJbcuWKC5hJh6RMEFmziORpHB23AgUDZGBTmoU+
         OfnKIQGj3KooB4ATvF7qZJAHay3Z4kqrE18YFWFPM6qZVjLoUq+bUrxatuu4orC5otbC
         bIyMLOsTcqyt2UcXOrIz0fyasLIA6KQUQqB4dAnONm9GlgcjJkK635H7HaU+FGUPBIN2
         6s1gXx3ZFqUJKaHfhfwtpEJXPFLaOd03DK8db64v8ZIiV0sC+LDCXfTUVjfEoylHqtTr
         JOdqdHZimZscMOpUJt3r6kdWK+XiaeUZjR48JcHb3swXHgG76YPCuNI7eVUqdxZv7bvQ
         iMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620406; x=1695225206;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KbpgIZY0S+jrnQeTU9MHb5yuccFEI2qq5nwURR5Z7vY=;
        b=XdHzzDxqV9tjSbGb/iFIedt6ezLUP/DWjgFAfo4DQFGcy4MOf0hRN8/VO0XrrZ9hmw
         WBRDppGeU2QjgnI/oaBU5OkV5bc9yxVeUNIZDpCFh2PfpRgna432lLLwUzNVj2RrdExb
         eGVwbW9BY76unbMPAuV2M5Vc2O3XZrKlEm/mLGb6i5IVP2PALpwLILkPryAk9O0cY/YN
         ovmUliCf0LOCEY1DpPvvu4HQkwZ0a0DMsMYjd6xPflORjbNiUs0kZ2wVjmyPD0yoDnxK
         Jy7R5WtWz2/E6Z7KK36PhXWxojRLY+JdqDFIL8z+H02bYamQexf+4NMLOckhxLfKmH7x
         4FOA==
X-Gm-Message-State: AOJu0YxBL38YVKDgOU86u5hI5L8CyDN+jTZT/ImWSG0ZIoWedsX5mXIO
        Mw+H1P6wnN6vSnRXyvLbPlm5gQ==
X-Google-Smtp-Source: AGHT+IG7uN/b0G0olfsBzT5JVx50eogSPAxxETPGl3o5DM9I5OGZFQgctwuNG29LxQ5Cb8CEXzO01g==
X-Received: by 2002:a05:600c:44c9:b0:3ff:a95b:9751 with SMTP id f9-20020a05600c44c900b003ffa95b9751mr4604899wmo.7.1694620405692;
        Wed, 13 Sep 2023 08:53:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm2400657wmk.35.2023.09.13.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:53:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 496A41FFBB;
        Wed, 13 Sep 2023 16:53:24 +0100 (BST)
References: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
 <CV7IJY36ZXDZ.250Z3B8VKN4Y5@ablu-work>
 <CVHKGP2HRKVG.TEIWT3U6ZVTX@ablu-work>
 <CVHU6DMDF441.2AQHB25WSIWR3@ablu-work>
User-agent: mu4e 1.11.17; emacs 29.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Erik Schilling <erik.schilling@linaro.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Richard Henderson <richard.henderson@linaro.org>,
        Weiwei Li <liweiwei@iscas.ac.cn>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        German Maglione <gmaglione@redhat.com>,
        Hanna Czenczek <hreitz@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [BUG] virtio-fs: Corruption when running binaries from
 virtiofsd-backed fs
Date:   Wed, 13 Sep 2023 16:38:12 +0100
In-reply-to: <CVHU6DMDF441.2AQHB25WSIWR3@ablu-work>
Message-ID: <87msxqrrwr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


"Erik Schilling" <erik.schilling@linaro.org> writes:

> CCing a few more people as suggested by stefanha on #qemu.

(Add philmd who's tracking the MIPs failure)

> On Wed Sep 13, 2023 at 8:18 AM CEST, Erik Schilling wrote:
>> On Fri Sep 1, 2023 at 12:37 PM CEST, Erik Schilling wrote:
>> > On Wed Aug 30, 2023 at 10:20 AM CEST, Erik Schilling wrote:
>> > > Hi all!
>> > >
>> > > Some days ago I posted to #virtiofs:matrix.org, describing that I am
>> > > observing what looks like a corruption when executing programs from a
>> > > virtiofs-based filesystem.
>> > >
>> > > Over the last few days I spent more time drilling into the problem.
>> > > This is an attempt at summarizing my findings in order to see what o=
ther
>> > > people think about this.
>> > >
>> > > When running binaries mounted from virtiofs they may either: fail wi=
th a
>> > > segfault, fail with badaddr, get stuck or - sometimes - succeed.
>> > >
>> > > Environment:
>> > >   Host: Fedora 38 running 6.4.11-200.fc38.x86_64
>> > >   Guest: Yocto-based image: 6.4.9-yocto-standard, aarch64
>> > >   virtiofsd: latest main + some debug prints [1]
>> > >   QEMU: built from recent git [2]
>> > >
>> > > virtiofsd invocation:
>> > >   RUST_LOG=3D"debug" ./virtiofsd --seccomp=3Dnone --sandbox=3Dnone \
>> > >     --socket-path "fs.sock0" --shared-dir $PWD/share-dir/ --cache=3D=
never
>> > >
>> > > QEMU invocation:
>> > >   ~/projects/qemu/build/qemu-system-aarch64 -kernel Image -machine v=
irt \
>> > >     -cpu cortex-a57 \
>> > >     -serial mon:stdio \
>> > >     -device virtio-net-pci,netdev=3Dnet0 \
>> > >     -netdev user,id=3Dnet0,hostfwd=3Dtcp::2223-:22 \
>> > >     -display none -m 2048 -smp 4 \
>> > >     -object memory-backend-memfd,id=3Dmem,size=3D2048M,share=3Don \
>> > >     -numa node,memdev=3Dmem \
>> > >     -hda trs-overlay-guest.qcow2 \
>> > >     -chardev socket,id=3Dchar0,path=3D"fs.sock0" \
>> > >     -device vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=
=3D/dev/root \
>> > >     -append 'root=3D/dev/vda2 ro log_buf_len=3D8M'
>> > >
>> > > I figured that launching virtiofsd with --cache=3Dalways masks the
>> > > problem. Therefore, I set --cache=3Dnever, but I think I observed no
>> > > difference compared to the default setting (auto).
>> > >
>> > > Adding logging to virtiofsd and kernel _feeled_ like it made the pro=
blem
>> > > harder to reproduce - leaving me with the impression that some race =
is
>> > > happening on somewhere.
>> > >
>> > > Trying to rule out that virtiofsd is returning corrupted data, I add=
ed
>> > > some logging and hashsum calculation hacks to it [1]. The hashes che=
ck
>> > > out across multiple accesses and the order and kind of queued messag=
es
>> > > is exactly the same in both the error case and crash case. fio was a=
lso
>> > > unable to find any errors with a naive job description [3].
>> > >
>> > > Next, I tried to capture info on the guest side. This became a bit
>> > > tricky since the crashes became pretty rare once I followed a fixed
>> > > pattern of starting log capture, running perf and trying to reproduce
>> > > the problem. Ultimately, I had the most consistent results with
>> > > immediately running a program twice:
>> > >
>> > >   /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /; \
>> > >     /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /
>> > >
>> > >   (/mnt being the virtiofs mount)
>> > >
>> > > For collecting logs, I made a hack to the guest kernel in order to d=
ump
>> > > the page content after receiving the virtiofs responses [4]. Reprodu=
cing
>> > > the problem with this, leaves me with logs that seem to suggest that
>> > > virtiofsd is returning identical content, but the guest kernel seems=
 to
>> > > receive differing pages:
>> > >
>> > > good-kernel [5]:
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x312 n=
odeid 0x1 in.len 56 out.len 104
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x314 n=
odeid 0x1 in.len 53 out.len 128
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x316 n=
odeid 0x29 in.len 56 out.len 104
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x318 =
nodeid 0x29 in.len 48 out.len 16
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x31a =
nodeid 0x29 in.len 80 out.len 832
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs: page: 000000006996d520
>> > >   kernel: virtio_fs: to: 00000000de590c14
>> > >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ................
>> > >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ................
>> > >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ................
>> > >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ................
>> > >   [...]
>> > >
>> > > bad-kernel [6]:
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x162 n=
odeid 0x1 in.len 56 out.len 104
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x164 n=
odeid 0x1 in.len 53 out.len 128
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x166 n=
odeid 0x16 in.len 56 out.len 104
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x168 =
nodeid 0x16 in.len 48 out.len 16
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x16a =
nodeid 0x16 in.len 80 out.len 832
>> > >   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>> > >   kernel: virtio_fs: page: 000000006ce9a559
>> > >   kernel: virtio_fs: to: 000000007ae8b946

Are these the copying from virtio to buffer cache? I would assume they
trigger -d trace:memory_notdirty_write_access if so.

>> > >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ................
>> > >   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ................
>> > >   kernel: virtio_fs rsp:80 40 de c8 ff ff 00 00 cc 2b 62 ae ff ff 00=
 00  .@.......+b.....
>> > >   kernel: virtio_fs rsp:02 4e de c8 ff ff 00 00 00 00 00 00 00 00 00=
 00  .N..............
>> > >   [...]
>> > >
>> > > When looking at the corresponding output from virtiofsd, it claims to
>> > > have returned identical data:
>> > >
>> > > good-virtiofsd [7]:
>> > >   [DEBUG virtiofsd::server] Received request: opcode=3DRead (15), in=
ode=3D41, unique=3D794, pid=3D481
>> > >   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? =
=3D ReadIn {
>> > >       fh: 31,
>> > >       offset: 0,
>> > >       size: 832,
>> > >       read_flags: 2,
>> > >       lock_owner: 6838554705639967244,
>> > >       flags: 131072,
>> > >       padding: 0,
>> > >   }
>> > >   [src/file_traits.rs:161] hash =3D 2308490450751364994
>> > >   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 84=
8, error: 0, unique: 794 }
>> > >
>> > > bad-virtiofsd [8]:
>> > >   [DEBUG virtiofsd::server] Received request: opcode=3DRead (15), in=
ode=3D22, unique=3D362, pid=3D406
>> > >   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? =
=3D ReadIn {
>> > >       fh: 12,
>> > >       offset: 0,
>> > >       size: 832,
>> > >       read_flags: 2,
>> > >       lock_owner: 6181120926258395554,
>> > >       flags: 131072,
>> > >       padding: 0,
>> > >   }
>> > >   [src/file_traits.rs:161] hash =3D 2308490450751364994
>> > >   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 84=
8, error: 0, unique: 362 }
>> > >
>> > > The "corruption" only seems to happen in this one page, all other pa=
ges
>> > > are identical between runs (except that the bad run terminates earli=
er).
>> > >
>> > > What do the experts think here? To me it feels a bit like some kind =
of
>> > > corruption is going on. Or am I misinterpreting things here?
>> > >
>> > > Which further analysis steps would you suggest?
>> > >
>> > >
>> > > Further notes:
>> > >
>> > > After collecting the above results, I realized that running the guest
>> > > with -smp 1 makes the problems a lot worse. So maybe that is a better
>> > > choice when trying to reproduce it.
>> > >
>> > > Repo with my scripts is available at:
>> > > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s=
-config/
>> > >
>> > > The scripts are just quick and dirty implementations and are not
>> > > particulary portable.
>> >
>> > Summary of my testing during the last few days:
>> >
>> > Testing with KCSAN revealed a few cases that look like missing READ_ON=
CE
>> > annotations (will send patches separately). But nothing of that was
>> > related to the immediate problem. I tested instrument_read() and anoth=
er
>> > round of logging with a delay to virtio_fs_request_complete. It looks
>> > like the buffer get corrupted before entering that function. KCSAN
>> > or manual sleeps + prints did not show any corruption while in that
>> > function.
>> >
>> > KASAN did not report any issues.
>> >
>> > Patching virtiofsd to do an additional copy and going through rust-vmm=
's
>> > .copy_to() function did not change the behaviour.
>> >
>> > I will mostly be off next week, will continue analysis afterwards. Hap=
py
>> > to hear about suggestions of other things to try :).
>>
>> Back from a week of vacation...
>>
>> Summary of what was discussed on #virtiofs:matrix.org:
>>
>> The issue only seems to happen in QEMU TCG scenarios (I tested aarch64
>> and x86_64 on x86_64, wizzard on Matrix tested arm32).
>>
>> CCing qemu-devel. Maybe someone has some hints on where to focus the
>> debugging efforts?
>>
>> I am trying to build a complex monster script of tracing the relevant
>> addresses in order to figure out whether the guest or host does the
>> writes. But I am happy to hear about more clever ideas :).
>
> After hearing about investigations of bugs in other virtio scenarios
> that seem to be caused by QEMU [9], I tested some older QEMU versions.
>
> Indeed, a882b5712373171d3bd53cd82ddab4453ddef468 did not show the buggy
> behaviour. So I did a bisect:
>
>     git bisect start
>     # status: waiting for both good and bad commits
>     # good: [a882b5712373171d3bd53cd82ddab4453ddef468] Revert "virtio:
> introduce macro IRTIO_CONFIG_IRQ_IDX"
>     git bisect good a882b5712373171d3bd53cd82ddab4453ddef468
>     # status: waiting for bad commit, 1 good commit known
>     # bad: [9ef497755afc252fb8e060c9ea6b0987abfd20b6] Merge tag
> 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging
>     git bisect bad 9ef497755afc252fb8e060c9ea6b0987abfd20b6
>     # skip: [3ba5fe46ea4456a16e2f47ab8e75943b54879c4e] Merge tag
> 'mips-20221108' of https://github.com/philmd/qemu into staging
>     git bisect skip 3ba5fe46ea4456a16e2f47ab8e75943b54879c4e
>     # skip: [ade760a2f63804b7ab1839fbc3e5ddbf30538718] Merge tag
> 'pull-request-2022-11-08' of https://gitlab.com/thuth/qemu into
> staging
>     git bisect skip ade760a2f63804b7ab1839fbc3e5ddbf30538718
>     # good: [ad2ca2e3f762b0cb98eb976002569795b270aef1] target/xtensa: Dro=
p tcg_temp_free
>     git bisect good ad2ca2e3f762b0cb98eb976002569795b270aef1
>     # bad: [19a720b74fde7e859d19f12c66a72e545947a657] Merge tag
> 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into
> staging
>     git bisect bad 19a720b74fde7e859d19f12c66a72e545947a657
>     # bad: [29d9efca16080211f107b540f04d1ed3c12c63b0] arm/Kconfig: Do
> not build TCG-only boards on a KVM-only build
>     git bisect bad 29d9efca16080211f107b540f04d1ed3c12c63b0
>     # good: [9636e513255362c4a329e3e5fb2c97dab3c5ce47] Merge tag
> 'misc-next-pull-request' of https://gitlab.com/berrange/qemu into
> staging
>     git bisect good 9636e513255362c4a329e3e5fb2c97dab3c5ce47
>     # bad: [45608654aa63ca2b311d6cb761e1522f2128e00e] Merge tag
> 'pull-tpm-2023-04-20-1' of https://github.com/stefanberger/qemu-tpm
> into staging
>     git bisect bad 45608654aa63ca2b311d6cb761e1522f2128e00e
>     # good: [1ff4a81bd3efb207992f1da267886fe0c4df764f] tcg: use QTree ins=
tead of GTree
>     git bisect good 1ff4a81bd3efb207992f1da267886fe0c4df764f
>     # bad: [9ed98cae151368cc89c4bb77c9f325f7185e8f09] block-backend:
> ignore inserted state in blk_co_nb_sectors
>     git bisect bad 9ed98cae151368cc89c4bb77c9f325f7185e8f09
>     # good: [c8cb603293fd329f2a62ade76ec9de3f462fc5c3] tests/avocado: Tes=
t Xen guest support under KVM
>     git bisect good c8cb603293fd329f2a62ade76ec9de3f462fc5c3
>     # bad: [64f1c63d87208e28e8e38c4ab514ada1728960ef] Merge tag
> 'pull_error_handle_fix_use_after_free.v1' of
> https://github.com/stefanberger/qemu-tpm into staging
>     git bisect bad 64f1c63d87208e28e8e38c4ab514ada1728960ef
>     # good: [8a712df4d4d736b7fe6441626677bfd271d95b15] Merge tag
> 'pull-for-8.0-040423-2' of https://gitlab.com/stsquad/qemu into
> staging
>     git bisect good 8a712df4d4d736b7fe6441626677bfd271d95b15
>     # bad: [7d0334e49111787ae19fbc8d29ff6e7347f0605e] Merge tag
> 'pull-tcg-20230404' of https://gitlab.com/rth7680/qemu into staging
>     git bisect bad 7d0334e49111787ae19fbc8d29ff6e7347f0605e
>     # bad: [3371802fba3f7be4465f8a5e5777d43d556676ef] accel/tcg: Fix jump=
 cache set in cpu_exec_loop
>     git bisect bad 3371802fba3f7be4465f8a5e5777d43d556676ef
>     # good: [6cda41daa2162b8e1048124655ba02a8c2b762b4] Revert
> "linux-user/arm: Take more care allocating commpage"
>     git bisect good 6cda41daa2162b8e1048124655ba02a8c2b762b4
>     # skip: [c83574392e0af108a643347712564f6749906413] accel/tcg: Fix ove=
rwrite problems of tcg_cflags
>     git bisect skip c83574392e0af108a643347712564f6749906413
>     # only skipped commits left to test
>     # possible first bad commit:
> [3371802fba3f7be4465f8a5e5777d43d556676ef] accel/tcg: Fix jump cache
> set in cpu_exec_loop

It should be possible to rule out the jump cache in HEAD by patching out
the two:

        if (likely(tb &&
                   tb->pc =3D=3D pc &&
                   tb->cs_base =3D=3D cs_base &&
                   tb->flags =3D=3D flags &&
                   tb_cflags(tb) =3D=3D cflags)) {
            return tb;
        }

functions to if(0) { return tb } in tb_lookup. That can rule out if a
corrupted jump cache is responsible (at the cost of running a bit
slower).

Apropos of earlier tb_jmp_cache_inval_tb() is responsible for removing
entries of TB's that are invalidated for whatever reason from the cache.

>     # possible first bad commit:
> [c83574392e0af108a643347712564f6749906413] accel/tcg: Fix overwrite
> problems of tcg_cflags
>
> I had an inclusive test in the end where c83574392e did not yield in me
> being able to start the VM.

It's interesting that is involved the PCREL stuff. This is a
relatively recent optimisation that allows us to re-use translations for
physical pages that are mapped into virtual memory multiple times. To do
that the target translator has to support CF_PCREL and translate only
knowing the PC as an offset into the page.

>
> Whether one of these contains a bug or whether only new behaviour of
> QEMU revealed a bug somewhere else is of course still to be figured out.
>
> [9] https://gitlab.com/qemu-project/qemu/-/issues/1866

This is follow up on #1826, #1834, #1846 which is all broadly to do with
how QEMU deals with updates to it's memory maps (e.g. when PCI devices
are remapped/reconfigured). We are unsure if the MIPS architecture
should be executing some sort of barrier around reconfiguration that can
ensure we exit the block or we have to detect mid-block IO accesses
icount style.

>
> - Erik
>
>>
>> - Erik
>>
>> >
>> > Good weekend,
>> >
>> > - Erik
>> >
>> >
>> > >
>> > > - Erik
>> > >
>> > > [1] https://gitlab.com/ablu/virtiofsd/-/commit/18fd0c1849e15bc55fbdd=
6e1f169801b2b03da1f
>> > > [2] https://gitlab.com/qemu-project/qemu/-/commit/50e7a40af372ee5931=
c99ef7390f5d3d6fbf6ec4
>> > > [3]
>> > > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s=
-config/-/blob/397a6310dea35973025e3d61f46090bf0c092762/share-dir/write-and=
-verify-mmap.fio
>> > > [4] https://github.com/Ablu/linux/commit/3880b9f8affb01aeabb0a04fe76=
ad7701dc0bb95
>> > > [5] Line 12923:
>> > > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s=
-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-drop-bad-=
1.txt
>> > > [6] Line 12923:
>> > > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s=
-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-bad-1.txt
>> > > [7]
>> > > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s=
-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#=
L2538-2549
>> > > [8]
>> > > https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s=
-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#=
L1052-1063


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
