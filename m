Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434A2681B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 21:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjA3UfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA3UfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:35:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E816AD1;
        Mon, 30 Jan 2023 12:35:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l4-20020a17090a850400b0023013402671so107674pjn.5;
        Mon, 30 Jan 2023 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=81a6SP2+O9L4e8NklswfbxTKGvzp4CxWamSApSDOPIA=;
        b=YAH2PvPoq5yP5t9+pXxOdqP39eihfK2afI7PQM6i1Ze8OgZFNIfKfglIFVSYMqRmAM
         8azSYXZVWguvJpzHYVbCzrtjIt2N125ebwVQNFi8XdVdycj4AdnWZcK+6g1ISMlbaHqd
         gXMCuWbYBobIdXkR60KRTVd1rLO/lvPn8Zyywq7cPhpzwKLloS6K8xECvafk+V5i6amH
         Vj7jTo1iKJxeP2f3v51LyQmREX85JJqMsgLbNMzCo2cLLsX8aH2Keew3pE2ksnLcNpFA
         0BgWpvYpAhvjxSEPwuzJePXXieDGWGikXLumXefKKqP2WT6vHEH1P1jU7A98O2xVtSuV
         SCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81a6SP2+O9L4e8NklswfbxTKGvzp4CxWamSApSDOPIA=;
        b=ibiGEF5LpIHACQHeeJkpye4ozdcsVx/IYy7nH+p639C3sk2EsEUbkpAEEk1lwB5pap
         McoonZB4OcmrBT3DxM5XFNWL/xoiSvE8cAApM2kyRdNvYm2QTZ9y7WD/PGqbpJUnwfPT
         G1bDZ2ncct//6kPzSBA/4cCgtmzUg6YHnPMV9g00PJH+9QEw+hSmK8gWNp2vdvbMZeN6
         iyQ6VGsqSKuJbz+29jLfMc0w39Rqoqp6lzPVPPVBLTUxub/v9duxSIADbXC/eO71yCgC
         OjfuLP97XmAijllZ32sDkqph7z4NhtEk8uGyHgCPdgmwJIrWTLWQeeHtRyACgX1wO9Eb
         RG9Q==
X-Gm-Message-State: AO0yUKUIBL3fXr72TZ0TPKq4kirHRMx+kbVinEusQGE65NMrA/LzBqXB
        tHCpzW0VaBmXizU/LXYEjg12xtAFVTA=
X-Google-Smtp-Source: AK7set+QNTCD7lRYq+VXoyDU/4i5Q7qNIWqMX+xrL5IXFVjhBNtoiePg1S/GM0udVvxrc0lAIWa07g==
X-Received: by 2002:a17:902:e84b:b0:196:6496:85fa with SMTP id t11-20020a170902e84b00b00196649685famr12341934plg.26.1675110901146;
        Mon, 30 Jan 2023 12:35:01 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b00189743ed3b6sm8248767plb.64.2023.01.30.12.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:35:00 -0800 (PST)
Date:   Tue, 31 Jan 2023 02:04:58 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <20230130203458.mmoua4a6q63ymhwr@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
 <Y9gEYUVuK24IpLMt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gEYUVuK24IpLMt@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/30 05:54PM, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 09:44:13PM +0530, Ritesh Harjani (IBM) wrote:
> > On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> > filesystem blocksize, this patch should improve the performance by doing
> > only the subpage dirty data write.
> >
> > This should also reduce the write amplification since we can now track
> > subpage dirty status within state bitmaps. Earlier we had to
> > write the entire 64k page even if only a part of it (e.g. 4k) was
> > updated.
> >
> > Performance testing of below fio workload reveals ~16x performance
> > improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> > FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> >
> > <test_randwrite.fio>
> > [global]
> > 	ioengine=psync
> > 	rw=randwrite
> > 	overwrite=1
> > 	pre_read=1
> > 	direct=0
> > 	bs=4k
> > 	size=1G
> > 	dir=./
> > 	numjobs=8
> > 	fdatasync=1
> > 	runtime=60
> > 	iodepth=64
> > 	group_reporting=1
> >
> > [fio-run]
>
> You really need to include this sentence from the cover letter in this
> patch:
>
> 2. Also our internal performance team reported that this patch improves there
>    database workload performance by around ~83% (with XFS on Power)
>
> because that's far more meaningful than "Look, I cooked up an artificial
> workload where this makes a difference".

Agreed. I will add the other lines too in the commit message.

The intention behind adding fio workload is for others to have a test
case to verify against and/or provide more info when someone later refers
to the commit message.
One of the interesting observation with this synthetic fio workload was we can
/should easily observe the theoritical performance gain of around ~16x
(i.e. 64k(ps) / 4k(bs)).

Thanks again for the review!
-ritesh
