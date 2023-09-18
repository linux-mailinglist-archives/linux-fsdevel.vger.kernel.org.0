Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A481C7A46D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbjIRKWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbjIRKVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F1AD
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695032456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yU55zmy+tifjpDLUpfSCylMp4XR9haoWnULzlns5xls=;
        b=MurVU8+4Z8s+Q3xe4MUZviebgLj4z+XkZBjVoHtT+yrFzLukOqY6hRs6ArcAQ0IRplHFr4
        fT5Gay35I/TtLS0MazWUFefNjgURxVA92RU5mG/LIa8bw3H1JM5Ua7pPStjsBtgJdOjbwG
        QwR5Irp0aEacpT4XrsQyWxuQoEEIlWM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-p1wsr2W2MTyIe0BKJ3ZKeg-1; Mon, 18 Sep 2023 06:20:55 -0400
X-MC-Unique: p1wsr2W2MTyIe0BKJ3ZKeg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27472e97c0bso2661078a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 03:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695032454; x=1695637254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yU55zmy+tifjpDLUpfSCylMp4XR9haoWnULzlns5xls=;
        b=oTvYqP7lk1CCqUoKfX2Ih0FJv7Q5q9IL7XaOGv1glEmn9KLn5h45zuCKl7U9bp0u44
         WVmfACq6QgmSqYAzdg0d3XKBaVAY2CmfSkft9evG9KHub215OwbQnQHr+wjo6fBSkE2r
         cMGYJR1MzsmBvpWSUnba0U2avKmtBEEqiy6aaQQSAc1kCjSdr+I5LtS6QV8L8a02TK0G
         hRShIieh4+1EZ2NthJ2frG+75pIgqJgq6+xuKrqz7Q5+JDmgz62e5FGTuh4cU3X6yT49
         terJe/vAl6fNtY01EsWUpyKK2TxK2TocNDDBF/nP1Hqna6YxRDBeIifBE4EALWP4KRYu
         vFzw==
X-Gm-Message-State: AOJu0YxNgPM+n/pePqmERyyK8xTpfuPtqW+lmggMd+pEkq9u3oR0K76r
        JLtRfHtTIcxE4WQyoXZVh46CUlgWRfP8tkmR5qcrTDrUqr50wjtp159KA+x1zz6+6niD8TKsY5D
        +HoH2F41h22iv4nYtVMEznBYymnjRD6ogIYCw18zp1w==
X-Received: by 2002:a17:90b:23c4:b0:259:466:940f with SMTP id md4-20020a17090b23c400b002590466940fmr5945979pjb.22.1695032454029;
        Mon, 18 Sep 2023 03:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEtH10NqI0T9ljzjjgrVprcPWZuTNpuV3VTBMkk2Q5qVxQsg5e+/Uzg2XIHnu21aI/ILioVf9Pa2At0kqn5VI=
X-Received: by 2002:a17:90b:23c4:b0:259:466:940f with SMTP id
 md4-20020a17090b23c400b002590466940fmr5945960pjb.22.1695032453718; Mon, 18
 Sep 2023 03:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <ZOWFtqA2om0w5Vmz@fedora> <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
 <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
 <89d049ed-6bbf-bba7-80d4-06c060e65e5b@huawei.com> <20230917091031.GA1543@noisy.programming.kicks-ass.net>
 <9efe2f14-c3d9-e526-d561-b6a0aca6c491@huawei.com>
In-Reply-To: <9efe2f14-c3d9-e526-d561-b6a0aca6c491@huawei.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 18 Sep 2023 18:20:41 +0800
Message-ID: <CAHj4cs-6M+fORJOGOxH3sO5BytBwi4y9hcnS+xQ3wLZO20UXWg@mail.gmail.com>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, mark.rutland@arm.com,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        chengzhihao <chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 9:10=E2=80=AFAM Baokun Li <libaokun1@huawei.com> wr=
ote:
>
> On 2023/9/17 17:10, Peter Zijlstra wrote:
> > On Sat, Sep 16, 2023 at 02:55:47PM +0800, Baokun Li wrote:
> >> On 2023/9/13 16:59, Yi Zhang wrote:
> >>> The issue still can be reproduced on the latest linux tree[2].
> >>> To reproduce I need to run about 1000 times blktests block/001, and
> >>> bisect shows it was introduced with commit[1], as it was not 100%
> >>> reproduced, not sure if it's the culprit?
> >>>
> >>>
> >>> [1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeff=
ery
> >> Hello, everyone=EF=BC=81
> >>
> >> We have confirmed that the merge-in of this patch caused hlist_bl_lock
> >> (aka, bit_spin_lock) to fail, which in turn triggered the issue above.
> >> [root@localhost ~]# insmod mymod.ko
> >> [   37.994787][  T621] >>> a =3D 725, b =3D 724
> >> [   37.995313][  T621] ------------[ cut here ]------------
> >> [   37.995951][  T621] kernel BUG at fs/mymod/mymod.c:42!
> >> [r[  oo 3t7@.l996o4c61al]h[o s T6t21] ~ ]#Int ernal error: Oops - BUG:
> >> 00000000f2000800 [#1] SMP
> >> [   37.997420][  T621] Modules linked in: mymod(E)
> >> [   37.997891][  T621] CPU: 9 PID: 621 Comm: bl_lock_thread2 Tainted:
> >> G            E      6.4.0-rc2-00034-g9257959a6e5b-dirty #117
> >> [   37.999038][  T621] Hardware name: linux,dummy-virt (DT)
> >> [   37.999571][  T621] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT=
 -SSBS
> >> BTYPE=3D--)
> >> [   38.000344][  T621] pc : increase_ab+0xcc/0xe70 [mymod]
> >> [   38.000882][  T621] lr : increase_ab+0xcc/0xe70 [mymod]
> >> [   38.001416][  T621] sp : ffff800008b4be40
> >> [   38.001822][  T621] x29: ffff800008b4be40 x28: 0000000000000000 x27=
:
> >> 0000000000000000
> >> [   38.002605][  T621] x26: 0000000000000000 x25: 0000000000000000 x24=
:
> >> 0000000000000000
> >> [   38.003385][  T621] x23: ffffd9930c698190 x22: ffff800008a0ba38 x21=
:
> >> 0000000000000001
> >> [   38.004174][  T621] x20: ffffffffffffefff x19: ffffd9930c69a580 x18=
:
> >> 0000000000000000
> >> [   38.004955][  T621] x17: 0000000000000000 x16: ffffd9933011bd38 x15=
:
> >> ffffffffffffffff
> >> [   38.005754][  T621] x14: 0000000000000000 x13: 205d313236542020 x12=
:
> >> ffffd99332175b80
> >> [   38.006538][  T621] x11: 0000000000000003 x10: 0000000000000001 x9 =
:
> >> ffffd9933022a9d8
> >> [   38.007325][  T621] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 =
:
> >> ffffd993320b5b40
> >> [   38.008124][  T621] x5 : ffff0001f7d1c708 x4 : 0000000000000000 x3 =
:
> >> 0000000000000000
> >> [   38.008912][  T621] x2 : 0000000000000000 x1 : 0000000000000000 x0 =
:
> >> 0000000000000015
> >> [   38.009709][  T621] Call trace:
> >> [   38.010035][  T621]  increase_ab+0xcc/0xe70 [mymod]
> >> [   38.010539][  T621]  kthread+0xdc/0xf0
> >> [   38.010927][  T621]  ret_from_fork+0x10/0x20
> >> [   38.011370][  T621] Code: 17ffffe0 90000020 91044000 9400000d (d421=
0000)
> >> [   38.012067][  T621] ---[ end trace 0000000000000000 ]---
> > Is this arm64 or something? You seem to have forgotten to mention what
> > platform you're using.
> >
> Sorry for the late reply.
> We tested both x86 and arm64, and the problem is only encountered under
> arm64.

Yeah, my reproduced environment is also aarch64.



>
> --
> With Best Regards,
> Baokun Li
> .
>


--=20
Best Regards,
  Yi Zhang

