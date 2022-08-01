Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E5586E15
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHAPwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiHAPwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:52:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F537F90
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 08:52:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y15so10828602plp.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UhDHeCWLOhaAEo22dv5YDw1Tk34JS4LMROuyflAlMYk=;
        b=cNnEkxHiSXtp8MHAZ1IgCk+flmGb1scKfycjhjafH4CAzpua5VUTIxzXwRVoah5WfJ
         jRJmwXeUUW5rmtPpG2zKS3u+n7yQZctM73NInch0mAT+R8qg/8HXG9tA0p5sTaFnBOZ2
         zKWG0Ygn1vflNbhFpXWXmFGQq/WulkJqOyQmUWR6acJQI4n/g/lvZ2vcPGH10Un6Cp82
         8z3IyeosNfwp1vs/dDeiUN0+SVmSZfEGrP8njayWthd4cNXOfBOxsqzUKTnwM1fQy+p5
         xZ2qlxBwwf1YOjipiY127iPw0pUvKJ500G4wEUU1Mb0hrNlDsQDU8xN7MCHbYD1CHUF/
         RT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UhDHeCWLOhaAEo22dv5YDw1Tk34JS4LMROuyflAlMYk=;
        b=YCvAHbo23JMFo0Tle9Sy4Atwh+N30x/PGT6f5RQI2I+h8cNTkcYoDAfJnuFZGJI5Ud
         6sZTD33o7QwaEYKq3jGvEqKzxox1r2PNXYLPvEeC1kFhm2eqstWCRIdcLLCn9qiKuUdt
         nP8DqX4Z91bs/3o1fNUSWw/G+a39zMvMUNtp/hO0kBpX0BifSgH9ZtBisKf3XfYx9U9C
         LLqY2Ouu3z1HFDEM4RX1mxt3GK/MXYq515xs+PtUxrqUEzCeFcvyGeb3jqII1WgHIZlj
         vUkk4ednzHpRw25HEGJCr2A0bDHrOMRM1WUf12QCZYa70QX4ej5MJVVKK26IvF1chJ+6
         HE8w==
X-Gm-Message-State: ACgBeo2amn+gYwGNn9ZJYZ6xuDIF5/5cEGgdjmCKyZn3pGL70MHAakVV
        5kEBLubAWLKk/EJ6PVfyPoePwXQPYuriOk0iaKu3LA==
X-Google-Smtp-Source: AA6agR5X7NbJ7BC+6toVUt2YvALua2SY0pe/5edw3hIxyETOGYhh9KSDAFauy/Ovkb7N4HGNzdmd94edZcKHwZYwVns=
X-Received: by 2002:a17:902:ce0e:b0:16c:7977:9d74 with SMTP id
 k14-20020a170902ce0e00b0016c79779d74mr17421027plg.92.1659369168436; Mon, 01
 Aug 2022 08:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220729215123.1998585-1-khazhy@google.com> <20220729222939.p6r4qs7gfgooay3n@quack3>
In-Reply-To: <20220729222939.p6r4qs7gfgooay3n@quack3>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 1 Aug 2022 11:52:36 -0400
Message-ID: <CACGdZYKk3Smqgd-dhN7D3uNbasT=RLnTTEbWdfNthOB6Kn8Tjg@mail.gmail.com>
Subject: Re: [PATCH] writeback: check wb shutdown for bw_dwork
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000df2b7805e52ffd7d"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000df2b7805e52ffd7d
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 29, 2022 at 6:29 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 29-07-22 14:51:23, Khazhismel Kumykov wrote:
> > This fixes a KASAN splat in timer interrupt after removing a device
> >
> > Move wb->work_lock to be irq-safe, as complete may be called from irq
> >
> > Fixes: 45a2966fd641 ("writeback: fix bandwidth estimate for spiky workload")
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>
> The patch looks good but I wish there are more details in the changelog
> because with this terse changelog I can only guess. I suppose something
> like:
Thanks for the comments, I sent an updated changelog. I hope you don't
mind me using your wording :) And I'll take note to not be shy in
messages for the future!
>
> writeback: avoid use after free after removing a device
>
> When a disk is removed, bdi_unregister() gets called to stop any further
> writeback and wait for the running one to complete. However while IO
> completes, wb_inode_writeback_end() will schedule another delayed writeback
> and by the time timer fires the bdi_writeback structure may be already
> freed. Fix the problem by checking whether bdi is still alive before
> scheduling new work in wb_inode_writeback_end(). Since this requires
> wb->work_lock and wb_inode_writeback_end() may get called from an
> interrupt, switch wb->work_lock to an irqsafe lock.
>
>                                                                 Honza
>
> > ---
> >  fs/fs-writeback.c   | 12 ++++++------
> >  mm/backing-dev.c    | 10 +++++-----
> >  mm/page-writeback.c |  6 +++++-
> >  3 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 05221366a16d..08a1993ab7fd 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -134,10 +134,10 @@ static bool inode_io_list_move_locked(struct inode *inode,
> >
> >  static void wb_wakeup(struct bdi_writeback *wb)
> >  {
> > -     spin_lock_bh(&wb->work_lock);
> > +     spin_lock_irq(&wb->work_lock);
> >       if (test_bit(WB_registered, &wb->state))
> >               mod_delayed_work(bdi_wq, &wb->dwork, 0);
> > -     spin_unlock_bh(&wb->work_lock);
> > +     spin_unlock_irq(&wb->work_lock);
> >  }
> >
> >  static void finish_writeback_work(struct bdi_writeback *wb,
> > @@ -164,7 +164,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
> >       if (work->done)
> >               atomic_inc(&work->done->cnt);
> >
> > -     spin_lock_bh(&wb->work_lock);
> > +     spin_lock_irq(&wb->work_lock);
> >
> >       if (test_bit(WB_registered, &wb->state)) {
> >               list_add_tail(&work->list, &wb->work_list);
> > @@ -172,7 +172,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
> >       } else
> >               finish_writeback_work(wb, work);
> >
> > -     spin_unlock_bh(&wb->work_lock);
> > +     spin_unlock_irq(&wb->work_lock);
> >  }
> >
> >  /**
> > @@ -2082,13 +2082,13 @@ static struct wb_writeback_work *get_next_work_item(struct bdi_writeback *wb)
> >  {
> >       struct wb_writeback_work *work = NULL;
> >
> > -     spin_lock_bh(&wb->work_lock);
> > +     spin_lock_irq(&wb->work_lock);
> >       if (!list_empty(&wb->work_list)) {
> >               work = list_entry(wb->work_list.next,
> >                                 struct wb_writeback_work, list);
> >               list_del_init(&work->list);
> >       }
> > -     spin_unlock_bh(&wb->work_lock);
> > +     spin_unlock_irq(&wb->work_lock);
> >       return work;
> >  }
> >
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index 95550b8fa7fe..de65cb1e5f76 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -260,10 +260,10 @@ void wb_wakeup_delayed(struct bdi_writeback *wb)
> >       unsigned long timeout;
> >
> >       timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
> > -     spin_lock_bh(&wb->work_lock);
> > +     spin_lock_irq(&wb->work_lock);
> >       if (test_bit(WB_registered, &wb->state))
> >               queue_delayed_work(bdi_wq, &wb->dwork, timeout);
> > -     spin_unlock_bh(&wb->work_lock);
> > +     spin_unlock_irq(&wb->work_lock);
> >  }
> >
> >  static void wb_update_bandwidth_workfn(struct work_struct *work)
> > @@ -334,12 +334,12 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb);
> >  static void wb_shutdown(struct bdi_writeback *wb)
> >  {
> >       /* Make sure nobody queues further work */
> > -     spin_lock_bh(&wb->work_lock);
> > +     spin_lock_irq(&wb->work_lock);
> >       if (!test_and_clear_bit(WB_registered, &wb->state)) {
> > -             spin_unlock_bh(&wb->work_lock);
> > +             spin_unlock_irq(&wb->work_lock);
> >               return;
> >       }
> > -     spin_unlock_bh(&wb->work_lock);
> > +     spin_unlock_irq(&wb->work_lock);
> >
> >       cgwb_remove_from_bdi_list(wb);
> >       /*
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 55c2776ae699..3c34db15cf70 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2867,6 +2867,7 @@ static void wb_inode_writeback_start(struct bdi_writeback *wb)
> >
> >  static void wb_inode_writeback_end(struct bdi_writeback *wb)
> >  {
> > +     unsigned long flags;
> >       atomic_dec(&wb->writeback_inodes);
> >       /*
> >        * Make sure estimate of writeback throughput gets updated after
> > @@ -2875,7 +2876,10 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
> >        * that if multiple inodes end writeback at a similar time, they get
> >        * batched into one bandwidth update.
> >        */
> > -     queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> > +     spin_lock_irqsave(&wb->work_lock, flags);
> > +     if (test_bit(WB_registered, &wb->state))
> > +             queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> > +     spin_unlock_irqrestore(&wb->work_lock, flags);
> >  }
> >
> >  bool __folio_end_writeback(struct folio *folio)
> > --
> > 2.37.1.455.g008518b4e5-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--000000000000df2b7805e52ffd7d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
/UbIw5ZqDzSZD+QwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAB2kM/dnvjLFQgOANm3u
6O2eeA2ns7z1bKAKieQOHylg6/QUVNni+2SneSjNFOL7zKYDtBMHUKgO3rKBJX/dJfvoR//2kO08
EJwmyX+bLsQT2TTkPa28tJsYOcW1ikfdH3YyiHExVlUrFFtpiEmAr1eGd2HceTBvTQJkhhkb+ulg
D5rKnhTMXtEOuP5gUf59gIwubIpqkpQTG/Ez2eBtlicznw3LBOKZ2msT+vdDFjQXrWBxPpdL3ll0
WdLiqC7rbo0uCQeFdhI4gi0CyUNeGXEjN0/qngDOR5RPl++zdVLTFOV0kf31NijoQZquscGXyUZ1
/IYjtCWWtKbMqFk6gmMxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAE31I/NNZSyeJ7AJhcbSqgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII6OIoSg
0sn5T4jH1nAIj/9f2TY/FnHxh85xhRNwF7o6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDgwMTE1NTI0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB4BnhvB2987/WssYdUd7W/f33u
EGmPGqXMqJmnolL+z+ftngwLDLHkUrYuGpkAgH2FRZxpZ7ztVMMjLHC6u5mLlsOkbQip9eFfGdGh
IoYKRnCYvvJbg9u4F5pNq+TwzlN7QfL544euV2kpr9hSvC/115cYwsluobZU/VQrxqBrp8Cx4mmt
lNdCAchIXCt8s5LcGe5WNTDz2fH7bT/8/4Ow0yhXYos3aeMoeTeXkloxrYHj1ou8pyP0pvT0MJfl
XblYu1KcXpRWJVDjOXcb8Uxtm0PhBd7kuZ026lUw8xBlDjiR8uF3cx4vnu5IrXDfUv0yGA6KZhKX
+JU/C2iHmxEM
--000000000000df2b7805e52ffd7d--
