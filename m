Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3193C5F480C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJDRJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDRJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3533E3D
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Oct 2022 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664903371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJOoGSUaL3iWxTJtVuQy14c5Paw+H8qeY/SUQM5IEZ0=;
        b=eiwnyzw7p/axWJ2bHVvHShPn0WWlG9F8wWvymxkxCodwguNSBg9YOoJ7Pol9lv5LnOEYNB
        A0jeoxgA3zS1oHFOfO+P4Jnr39PUC3OJw+WnTT1xYvGqQyGTQPozOwHJO2vyBGT0YmVrjm
        3zJ+W+tAwGv+i6YMIDygv7p/Hvl5zK4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-Jo5sessaN2uiYNdfQrpLTQ-1; Tue, 04 Oct 2022 13:09:30 -0400
X-MC-Unique: Jo5sessaN2uiYNdfQrpLTQ-1
Received: by mail-qt1-f198.google.com with SMTP id cb22-20020a05622a1f9600b0035bb51792d2so9659993qtb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Oct 2022 10:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gJOoGSUaL3iWxTJtVuQy14c5Paw+H8qeY/SUQM5IEZ0=;
        b=c6TBzL9HwQpSZnSrKXozeoO2rfQFV3ufAwggFWQdxMGvBqBzdv/nQy+D3/0rhAmHRs
         ClujcccRB3T0o4CWg48vm0xzl7v1hEZWDULxBgOWvFg5KditI0qovCXCU0chBc6SgUjM
         my1C++4UtFbAbNkZnyqGtXdsouI8AVSmv7fzEhffVwRtIDPyRCCeCiNarkoXpCqVlytK
         jMZNz81JMALgBskEP2tLlDGFhexQrb6rXmkNULa8JZXToWil/qdVcIEZPdh5zmsQ3xx/
         29vNU6hvWQDekYBl5HfRdR+2+mM8acK29PCu04aCqZ4CGYVyGFLtRSOtPQdSq5Jhz5l9
         4gXw==
X-Gm-Message-State: ACrzQf2qhEBGox9RwWk0uMKYlPoEvEiNOKKltYvcCZN/H/JhKWbDz+5M
        WNx9ETUtKANVT5omQmFkeU2XQ5OUf/H99wxjRloDC4EfPXCkucumlXrEsQhm74AdmbB5kNHuANW
        bKLO/mOhR2UuiJFd7ULWDa0LKwA==
X-Received: by 2002:a05:622a:1014:b0:35c:e8ef:a406 with SMTP id d20-20020a05622a101400b0035ce8efa406mr20841891qte.306.1664903369655;
        Tue, 04 Oct 2022 10:09:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/KjePKEGls0FnVtStSDFhMNJt4/LwsertDJd0cT8+EVUSX5VHxNETDsI0ptHRXGJ+5hZxiQ==
X-Received: by 2002:a05:622a:1014:b0:35c:e8ef:a406 with SMTP id d20-20020a05622a101400b0035ce8efa406mr20841867qte.306.1664903369345;
        Tue, 04 Oct 2022 10:09:29 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a454500b006bb87c4833asm15204528qkp.109.2022.10.04.10.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:09:28 -0700 (PDT)
Date:   Tue, 4 Oct 2022 13:09:25 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2 RESEND] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <Yzxoxa9g1AyIlIj0@bfoster>
References: <20220923140334.514276-1-bfoster@redhat.com>
 <YzjV/qCcHDH7gfLZ@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzjV/qCcHDH7gfLZ@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 02, 2022 at 01:06:22AM +0100, Al Viro wrote:
> On Fri, Sep 23, 2022 at 10:03:34AM -0400, Brian Foster wrote:
> 
> > incompatible with O_CREAT. Otherwise the tradeoff for this change is
> > that this may impact behavior when an absolute path O_CREAT lookup
> > lands on a symlink that contains another absolute path. The unlazy
> > sequence of the create lookup now clears the nd->root mount pointer,
> > which means that once we read said link via step_into(), the
> > subsequent nd_jump_root() calls into set_root() to grab the mount
> > pointer again (from refwalk mode). This is historical behavior for
> > O_CREAT and less common than the current behavior of a typical
> > create lookup unnecessarily legitimizing the root dentry.
> 
> I'm not worried about the overhead of retrieving the root again;
> using the different values for beginning and the end of pathwalk,
> OTOH...
> 
> It's probably OK, but it makes analysis harder.  Do we have a real-world
> testcases where the contention would be observable?
> 

The reproducer was an old aim7 benchmark doing open(O_CREAT)'s and
close()'s. The only way I was able to reproduce it at the time was to
scale out open(O_CREAT)'s of prexisting files across many different
submounts, which ended up being limited by the root entry of the rootfs.
If I try to run a sustained file allocation workload in a similar
environment, then the underlying filesystems tend to bottleneck before
this particular dentry lock and it's not really noticeable from what I
can see (though I don't think I have as fast storage as the original
reporter).

My thought process for this patch was not so much that the workload was
critical, but rather that the regression seemed an unintentional side
effect of refactoring and easy enough to avoid.

Brian

