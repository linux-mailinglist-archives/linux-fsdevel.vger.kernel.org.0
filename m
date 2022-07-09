Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103E456C4FD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 02:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGIARX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 20:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGIARV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF28F774A8
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657325840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ko4GkJU0Tn8zbLKOIgGsmDKDvugLe86WnU6pUPW6HE=;
        b=U338edKG+kJ8/fMoEg8NNhJkj/pzhmZdFpjDrCJv6kezxLlCfjvkPEneWsJPMZ/azJn5Z0
        YV5aYJFZTVk5KjFTj3WfQEnVfsLHqUYsdO80CdSmsy5zAt9UgGWA/3R+zW35izEwaAUhU/
        N3Er3JFmc7QUf4wzJG2EC482cKZkiO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-Qq9SNVonNPKWeLsxs3H5wQ-1; Fri, 08 Jul 2022 20:17:09 -0400
X-MC-Unique: Qq9SNVonNPKWeLsxs3H5wQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB45101A54E;
        Sat,  9 Jul 2022 00:17:09 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A579AC35979;
        Sat,  9 Jul 2022 00:17:08 +0000 (UTC)
Date:   Sat, 9 Jul 2022 08:17:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, akpm@linux-foundation.org
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <20220709001704.GA342876@MiWiFi-R3L-srv>
References: <20220704081839.2232996-1-niejianglei2021@163.com>
 <YsfsIzjmhR5VQU3N@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsfsIzjmhR5VQU3N@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/08/22 at 04:34pm, Baoquan He wrote:
> On 07/04/22 at 04:18pm, Jianglei Nie wrote:
> > elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> > kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> > predefined value. If parse_crash_elf_headers() occurs some error and
> > returns a negetive value, the elfcorehdr_addr should be released with
> > elfcorehdr_free().
> > 
> > We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> > fails.
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Sorry, I didn't check the code change carefully. This v2 is not right. I
thought Jianglei took my suggested code change directly. Seems he
mistakenly took part of them and caused error.

> 
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  fs/proc/vmcore.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4eaeb645e759..86887bd90263 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
> >  	rc = parse_crash_elf_headers();
> >  	if (rc) {
> >  		pr_warn("Kdump: vmcore not initialized\n");
> > -		return rc;
> > +		goto fail;
> >  	}
> >  	elfcorehdr_free(elfcorehdr_addr);
        ~~
        this line should be removed.
> >  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> > @@ -1577,6 +1577,9 @@ static int __init vmcore_init(void)
> >  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
> >  	if (proc_vmcore)
> >  		proc_vmcore->size = vmcore_size;
> > +
> > +fail:
> > +	elfcorehdr_free(elfcorehdr_addr);
> >  	return 0;
        ^
        return rc;  the returned value is wrong with v2.

What I suggested is as below. 

Andrew, please drop the one merged into mm-unstable branch.

Hi Jianglei,

Can you post v3 with below correct change and add Andrew to CC?

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..390515c249dd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1569,15 +1569,16 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
-	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
-	return 0;
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
+	return rc;
 }
 fs_initcall(vmcore_init);
 

