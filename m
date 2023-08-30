Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7B78DBD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbjH3Shu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242377AbjH3IUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:20:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B56137
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 01:20:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a2185bd83cso696444666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693383604; x=1693988404; darn=vger.kernel.org;
        h=message-id:from:to:cc:subject:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6VGj+d59SoWScxEJA9LEHL+NP9IQEEXMEE3Jz1KTmE=;
        b=VrpS5ohabe5nywdFm+Cc+CUeqfy0iOhoM+tNYh5srlxOfusP9o4waQ+e/GeQtqAUAU
         cZzV/xGYFI0UuHelWi8s8gw2Dg4JRlTe1fXDKx7kMUFSuVuHQ6H8ahhIDEu5+2B95PUt
         PTIZ48rmAWSQecZSJ2y59c1j97eTbqDRp/3Lg3Oy2T5+6TGBTBJ6yknpN8CJ+Dlzs5Aw
         hBHqxuCqdIQ4sfolFm9J4A3TsXYH4YWTev93FXKWsPrsXDxEyIqu/TGtr371On/xlAHV
         fKXn7j59UxSc5pKTVPeQvmvzm6fnJl00NopWb/7N4MW+H+PCTrH8f78McfQEa662ugth
         cqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693383604; x=1693988404;
        h=message-id:from:to:cc:subject:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6VGj+d59SoWScxEJA9LEHL+NP9IQEEXMEE3Jz1KTmE=;
        b=T2oyzP3/eDhWWDoUkJdabGG/KiE7ZRVNgsYKjrWj067ZyKjCRVowf+s6tn9PFTK5Wh
         9dVhjj+bBjjD9p/QmH0Y20GrpbLzmD9goPzfg3I6gpovwiSBH1Zsq712EfRsUKaXQhTR
         4IRTqJ55Ehzml04RBuATmPlg5HrrQHMxDr87YICkQk66R622SoCpvUYaEIPorX3kunYX
         G1/n2Jyo/iZ7v05HPq88sTv+4sdoTq7C0VRktsc9IWFbHvCxYes7KQquXyu6M44IuHwr
         t8SOQEgMZLV4AmGovAEe972qlQq111tw1o13lMUFKZX8r4h1e4PXCc6eBItNwVeoHZD5
         65Iw==
X-Gm-Message-State: AOJu0Yy4v2ndbtVKGyMwYkt8U/BVKpyimwG5uGIjgGdiTp449NcAWOrW
        oM86qQlIqS+j1j4CHNJAJY13Cw==
X-Google-Smtp-Source: AGHT+IHFxvO3jlwRiHmVZZYo1no1C+kGX8loBNW1O4lukkTrd+G3TjMJ3gOMP7FiQZfSy3FIDZQVAQ==
X-Received: by 2002:a17:907:272a:b0:9a2:23cd:f05a with SMTP id d10-20020a170907272a00b009a223cdf05amr1099799ejl.76.1693383603775;
        Wed, 30 Aug 2023 01:20:03 -0700 (PDT)
Received: from localhost (i5C7438EA.versanet.de. [92.116.56.234])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b0099cc3c7ace2sm7050010ejf.140.2023.08.30.01.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 01:20:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 30 Aug 2023 10:20:02 +0200
Subject: [BUG] virtio-fs: Corruption when running binaries from
 virtiofsd-backed fs
Cc:     "Vivek Goyal" <vgoyal@redhat.com>,
        "Stefan Hajnoczi" <stefanha@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>
To:     <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <virtio-fs@redhat.com>
From:   "Erik Schilling" <erik.schilling@linaro.org>
Message-Id: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
X-Mailer: aerc 0.15.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all!

Some days ago I posted to #virtiofs:matrix.org, describing that I am
observing what looks like a corruption when executing programs from a
virtiofs-based filesystem.

Over the last few days I spent more time drilling into the problem.
This is an attempt at summarizing my findings in order to see what other
people think about this.

When running binaries mounted from virtiofs they may either: fail with a
segfault, fail with badaddr, get stuck or - sometimes - succeed.

Environment:
  Host: Fedora 38 running 6.4.11-200.fc38.x86_64
  Guest: Yocto-based image: 6.4.9-yocto-standard, aarch64
  virtiofsd: latest main + some debug prints [1]
  QEMU: built from recent git [2]

virtiofsd invocation:
  RUST_LOG=3D"debug" ./virtiofsd --seccomp=3Dnone --sandbox=3Dnone \
    --socket-path "fs.sock0" --shared-dir $PWD/share-dir/ --cache=3Dnever

QEMU invocation:
  ~/projects/qemu/build/qemu-system-aarch64 -kernel Image -machine virt \
    -cpu cortex-a57 \
    -serial mon:stdio \
    -device virtio-net-pci,netdev=3Dnet0 \
    -netdev user,id=3Dnet0,hostfwd=3Dtcp::2223-:22 \
    -display none -m 2048 -smp 4 \
    -object memory-backend-memfd,id=3Dmem,size=3D2048M,share=3Don \
    -numa node,memdev=3Dmem \
    -hda trs-overlay-guest.qcow2 \
    -chardev socket,id=3Dchar0,path=3D"fs.sock0" \
    -device vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=3D/dev/=
root \
    -append 'root=3D/dev/vda2 ro log_buf_len=3D8M'

I figured that launching virtiofsd with --cache=3Dalways masks the
problem. Therefore, I set --cache=3Dnever, but I think I observed no
difference compared to the default setting (auto).

Adding logging to virtiofsd and kernel _feeled_ like it made the problem
harder to reproduce - leaving me with the impression that some race is
happening on somewhere.

Trying to rule out that virtiofsd is returning corrupted data, I added
some logging and hashsum calculation hacks to it [1]. The hashes check
out across multiple accesses and the order and kind of queued messages
is exactly the same in both the error case and crash case. fio was also
unable to find any errors with a naive job description [3].

Next, I tried to capture info on the guest side. This became a bit
tricky since the crashes became pretty rare once I followed a fixed
pattern of starting log capture, running perf and trying to reproduce
the problem. Ultimately, I had the most consistent results with
immediately running a program twice:

  /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /; \
    /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /

  (/mnt being the virtiofs mount)

For collecting logs, I made a hack to the guest kernel in order to dump
the page content after receiving the virtiofs responses [4]. Reproducing
the problem with this, leaves me with logs that seem to suggest that
virtiofsd is returning identical content, but the guest kernel seems to
receive differing pages:

good-kernel [5]:
  kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x312 nodeid 0=
x1 in.len 56 out.len 104
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x314 nodeid 0=
x1 in.len 53 out.len 128
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x316 nodeid 0=
x29 in.len 56 out.len 104
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x318 nodeid =
0x29 in.len 48 out.len 16
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x31a nodeid =
0x29 in.len 80 out.len 832
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs: page: 000000006996d520
  kernel: virtio_fs: to: 00000000de590c14
  kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..=
..............
  kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..=
..............
  kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..=
..............
  kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..=
..............
  [...]

bad-kernel [6]:
  kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x162 nodeid 0=
x1 in.len 56 out.len 104
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x164 nodeid 0=
x1 in.len 53 out.len 128
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x166 nodeid 0=
x16 in.len 56 out.len 104
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x168 nodeid =
0x16 in.len 48 out.len 16
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x16a nodeid =
0x16 in.len 80 out.len 832
  kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
  kernel: virtio_fs: page: 000000006ce9a559
  kernel: virtio_fs: to: 000000007ae8b946
  kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..=
..............
  kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..=
..............
  kernel: virtio_fs rsp:80 40 de c8 ff ff 00 00 cc 2b 62 ae ff ff 00 00  .@=
.......+b.....
  kernel: virtio_fs rsp:02 4e de c8 ff ff 00 00 00 00 00 00 00 00 00 00  .N=
..............
  [...]

When looking at the corresponding output from virtiofsd, it claims to
have returned identical data:

good-virtiofsd [7]:
  [DEBUG virtiofsd::server] Received request: opcode=3DRead (15), inode=3D4=
1, unique=3D794, pid=3D481
  [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? =3D ReadI=
n {
      fh: 31,
      offset: 0,
      size: 832,
      read_flags: 2,
      lock_owner: 6838554705639967244,
      flags: 131072,
      padding: 0,
  }
  [src/file_traits.rs:161] hash =3D 2308490450751364994
  [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, erro=
r: 0, unique: 794 }

bad-virtiofsd [8]:
  [DEBUG virtiofsd::server] Received request: opcode=3DRead (15), inode=3D2=
2, unique=3D362, pid=3D406
  [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? =3D ReadI=
n {
      fh: 12,
      offset: 0,
      size: 832,
      read_flags: 2,
      lock_owner: 6181120926258395554,
      flags: 131072,
      padding: 0,
  }
  [src/file_traits.rs:161] hash =3D 2308490450751364994
  [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, erro=
r: 0, unique: 362 }

The "corruption" only seems to happen in this one page, all other pages
are identical between runs (except that the bad run terminates earlier).

What do the experts think here? To me it feels a bit like some kind of
corruption is going on. Or am I misinterpreting things here?

Which further analysis steps would you suggest?


Further notes:

After collecting the above results, I realized that running the guest
with -smp 1 makes the problems a lot worse. So maybe that is a better
choice when trying to reproduce it.

Repo with my scripts is available at:
https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-config=
/

The scripts are just quick and dirty implementations and are not
particulary portable.

- Erik

[1] https://gitlab.com/ablu/virtiofsd/-/commit/18fd0c1849e15bc55fbdd6e1f169=
801b2b03da1f
[2] https://gitlab.com/qemu-project/qemu/-/commit/50e7a40af372ee5931c99ef73=
90f5d3d6fbf6ec4
[3] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-co=
nfig/-/blob/397a6310dea35973025e3d61f46090bf0c092762/share-dir/write-and-ve=
rify-mmap.fio
[4] https://github.com/Ablu/linux/commit/3880b9f8affb01aeabb0a04fe76ad7701d=
c0bb95
[5] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-boot=
strap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-=
drop-bad-1.txt
[6] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-boot=
strap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/good-=
bad-1.txt
[7] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-co=
nfig/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L25=
38-2549
[8] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-co=
nfig/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L10=
52-1063

