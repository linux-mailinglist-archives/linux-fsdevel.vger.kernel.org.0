Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B017AB284
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 15:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjIVNI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 09:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjIVNI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:08:27 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE918F
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 06:08:20 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230922130818epoutp03bbb3d3aa9f825133bce1e4bbc1bc5d96~HOn43Nia_1242612426epoutp03b
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 13:08:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230922130818epoutp03bbb3d3aa9f825133bce1e4bbc1bc5d96~HOn43Nia_1242612426epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695388098;
        bh=EW6qBVeJ9IHrRbrFtaqMksl/J70ZrQ6wvJiYL6lk6PU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=U7H85Mxo/bMNejk0SxSIhqgQxztq8nJ4mcuPi8VJRnCra5loR51bWYfokaUuMIPBF
         6TV8fhgoP5FRuvwMa7hSjrMJgWrfWlkWxQc1qu8Sckx/Y5wGBUZzxUc5Wlbo9ceisu
         vGkKEhQbGpA5Jcc5DCm1dKuYjiSOw9kjzhvNVosw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230922130816epcas2p33d271a48d44365bb0a9300ff2edff03a~HOn3V3NrS2769427694epcas2p33;
        Fri, 22 Sep 2023 13:08:16 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RsXdD20k3z4x9Pv; Fri, 22 Sep
        2023 13:08:16 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-6f-650d91c036dc
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.06.09693.0C19D056; Fri, 22 Sep 2023 22:08:16 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v16 04/12] block: add emulation for copy
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Nitesh Jagadeesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "anuj1072538@gmail.com" <anuj1072538@gmail.com>,
        SSDR Gost Dev <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Vincent Kang Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230920080756.11919-5-nj.shetty@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230922130815epcms2p631fc5fc5ebe634cc948fef1992f83a38@epcms2p6>
Date:   Fri, 22 Sep 2023 22:08:15 +0900
X-CMS-MailID: 20230922130815epcms2p631fc5fc5ebe634cc948fef1992f83a38
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf1DTZRzHe/b9sg1q3NcJ+DTO4oYZPwI2gu2RoCOk+OaPg4o778hz7dg3
        4Bjb2nezMlwoCogHgZzlTQlHHMQwYfzcJDgaIJgSJUFBinlscDYRhEATsGCD7I/+ez3ve38+
        7+fzee5hY9x8Fo+dodBQaoVUzmd64K3dgeKQrlIOJbDMeaD67y9j6P7CEo6OlqxgqO7mZ0zk
        6J4DyNaVD9AdayDquHfWDY12WRiotq6XgU5ZRwCyD+sZqGMsGBnyqnD0bccVHA1dOsdEFdV2
        Fjr5i5mJavoeM9CvJXaAzLYjALUuVWDoomMGR/1jvmjiZAFAgyt9brE80qK/ySIHx004OTSg
        JRuNJ5hkU9WnZPtoDpP8qrjMjSzKvcck79vHcHKmc5hJFjcbATnf+BzZaJtmJHFSMqPTKamM
        UvtRilSlLEORFsPf/Y5kpyRSJBCGCHcgMd9PIc2iYvjxe5JC3siQry6C73dQKteuSklSmuaH
        vRqtVmo1lF+6ktbE8CmVTK4Sq0JpaRatVaSFKihNlFAgCI9cNb6XmV7eY2OpmkUf2a0NIAc8
        iCgE7mxIRMCf7prcCoEHm0uYAXQMzmOFgM3mEJvginnzmmczEQ2banvc1phL8OEPF/TApQvg
        sd/y8DVmEqHQPNXOWuvjRVzFoPnv22DtgBF9bnB4cYjhSuPAM/l23MW+sK2mxdnJnXgFnrPm
        rusB8GF1EeZibzhaN83a4JnLFcDFXvD4+MC6ZxP8/a/2df1ZaLUuMNcGgIQSNnS95ZKzYd6j
        mXV7GBwpMDmjOMReeKFc79Rx4gVY8WP/+hXiYW1xuTMWI4JhtcHh3AlGBML6S2Gu7v6wZwx3
        OTxhQfcKa2PAHNPS/7L5SxvDVbodVh4NLwH++id71v8nSv8k6jzAjMCHUtFZaRQdrhL++7Sp
        yqxG4PwRQa+bQdn0bKgVMNjACiAb43txUuc8KC5HJv34EKVWStRaOUVbQeTqkKUYzztVufql
        FBqJMGKHIEIkEorDIwVi/hbO+PFyGZdIk2qoTIpSUeqNOgbbnZfDGKjZL3zgOzsg+eDluMRR
        +/B3vTfaSggldq1Sx/MPSBYFjyQvBeg0p7bGGujOd5sPXDny/OyuFI/9px/deSYv8VbGiabg
        ea8Ex9lrukrjVSzp/aBJoHiJ3rLk2Ne7V5J9aGqiNda0LOuPuNjSGGj0DH1x67G66+Yzp+0Z
        1IER2i/5oOdCFGpfvLXt8+HdH4rL34yfsSXM9AVl1SjTE0UPHy+PGhKSUt11nO2W27zzdKf2
        6z99TAOTOoO38nBx8cTPi0+buK8Vtdzt5Rs+EW+Li6rKTYl8Kns5bjE86I+CXJ/rmgaeMtry
        dnSrJSZGXrlvak+boH7yxi6j7psyefbhUuMXOB+n06XCIExNS/8BGm04MpoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1
References: <20230920080756.11919-5-nj.shetty@samsung.com>
        <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1@epcms2p6>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static void blkdev_copy_emulation_work(struct work_struct *work)
> +=7B
> +=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20blkdev_copy_emulation_io=20=
*emulation_io=20=3D=20container_of(work,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20struct=20blkdev_copy_emulation_io,=20emulation_work);=0D=0A>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20blkdev_copy_io=20*cio=20=3D=20=
emulation_io->cio;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20b=
io=20*read_bio,=20*write_bio;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20loff_t=20pos_in=20=3D=20emulation_io->pos_in,=20pos_out=20=3D=20emulatio=
n_io->pos_out;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ssize_t=20rem,=
=20chunk;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20ret=20=3D=200=
;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20for=20(rem=20=3D=
=20emulation_io->len;=20rem=20>=200;=20rem=20-=3D=20chunk)=20=7B=0D=0A>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20chu=
nk=20=3D=20min_t(int,=20emulation_io->buf_len,=20rem);=0D=0A>=20+=0D=0A>=20=
+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20re=
ad_bio=20=3D=20bio_map_buf(emulation_io->buf,=0D=0A>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0emulation_io->buf_len,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0emulat=
ion_io->gfp);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20if=20(IS_ERR(read_bio))=20=7B=0D=0A>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20ret=20=3D=20PTR_ERR(read_bio);=0D=0A>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20break;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20read_bio->bi_opf=20=3D=20RE=
Q_OP_READ=20=7C=20REQ_SYNC;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20bio_set_dev(read_bio,=20emulation_io->b=
dev_in);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20read_bio->bi_iter.bi_sector=20=3D=20pos_in=20>>=20SECTOR_=
SHIFT;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20read_bio->bi_iter.bi_size=20=3D=20chunk;=0D=0A>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ret=20=3D=20=
submit_bio_wait(read_bio);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20kfree(read_bio);=0D=0A=0D=0AHi,=20Nites=
h,=0D=0A=0D=0Ablk_mq_map_bio_put(read_bio)?=0D=0Aor=20bio_uninit(read_bio);=
=20kfree(read_bio)?=0D=0A=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(ret)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20break;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20write_bio=20=3D=20bio_map_buf(emulat=
ion_io->buf,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20emulation_io->buf_len=
,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20emulation_io->gfp);=0D=0A>=20+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(=
IS_ERR(write_bio))=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ret=20=
=3D=20PTR_ERR(write_bio);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20break;=
=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=7D=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20write_bio->bi_opf=20=3D=20REQ_OP_WRITE=20=7C=20REQ_SYN=
C;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20bio_set_dev(write_bio,=20emulation_io->bdev_out);=0D=0A>=20+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20write_=
bio->bi_iter.bi_sector=20=3D=20pos_out=20>>=20SECTOR_SHIFT;=0D=0A>=20+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20write_=
bio->bi_iter.bi_size=20=3D=20chunk;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ret=20=3D=20submit_bio_wait(wr=
ite_bio);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20kfree(write_bio);=0D=0A=0D=0Ablk_mq_map_bio_put(write_bio=
)=20?=0D=0Aor=20bio_uninit(write_bio);=20kfree(write_bio)?=0D=0A=0D=0Ahmm..=
.=20=0D=0AIt=20continuously=20allocates=20and=20releases=20memory=20for=20b=
io,=0D=0AWhy=20don't=20you=20just=20allocate=20and=20reuse=20bio=20outside=
=20the=20loop?=0D=0A=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(ret)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20break;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20pos_in=20+=3D=20chunk;=0D=0A>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20pos_out=
=20+=3D=20chunk;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cio->status=20=3D=20ret;=0D=0A>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20kvfree(emulation_io->buf);=0D=0A>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20kfree(emulation_io);=0D=0A=0D=0AI=20hav=
e=20not=20usually=20seen=20an=20implementation=20that=20releases=20memory=
=20for=0D=0Aitself=20while=20performing=20a=20worker.=20(=20I=20don't=20kno=
w=20what's=20right.=20:)=20)=0D=0A=0D=0ASince=20blkdev_copy_emulation()=20a=
llocates=20memory=20for=20the=20emulation=20=0D=0Aand=20waits=20for=20it=20=
to=20be=20completed,=20wouldn't=20it=20be=20better=20to=20proceed=0D=0Awith=
=20the=20memory=20release=20for=20it=20in=20the=20same=20context?=0D=0A=0D=
=0AThat=20is,=20IMO,=20wouldn't=20it=20be=20better=20to=20free=20the=20memo=
ry=20related=20to=0D=0Aemulation=20in=20blkdev_copy_wait_io_completion()?=
=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.=0D=0A=0D=0A=0D=0A=0D=0A
