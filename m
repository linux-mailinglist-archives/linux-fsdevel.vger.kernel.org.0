Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2016D64A86D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 21:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiLLUJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 15:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiLLUI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:08:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F1175AE;
        Mon, 12 Dec 2022 12:08:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id co23so13382111wrb.4;
        Mon, 12 Dec 2022 12:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBYX0Bgct53uW6OYZnLeYHLy/9+c4kuah33Xo7h5GMc=;
        b=MVl5ZiJTcKmUY1/MYMx9OVoFugiZCKG6Ah+BAinij8e0fX5ra7K78mqtzyLq94FWsA
         In14DzMhzoiX2ZkEKYnOxCKVmOXg4w0HqKCmjztjwAXkGd7LmaZ55iJ2aokxhHoCZWBs
         MeKLtTggXzJFLK22L3FQR+T9FLg4tndpSIXd/fVlQWzk/iXC7RPoKU5RYSJLxOXact+L
         z0q/lyEpw3noibsLuXSBpOdQm79ep0K2S8ApF8Zfxy7m2PXKx+Y8pvOW/WM/2r5VR8K7
         Y+KQZEYAriGwBWIQTq9/Js9p6bLMXRvOLa1kOVtMXFzcINS+sYqqxr6ksMfFiqsRey7w
         Ei2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBYX0Bgct53uW6OYZnLeYHLy/9+c4kuah33Xo7h5GMc=;
        b=OGmMZdeWZIkpIa2w/8P8MpcIyGSsKJ4hFitXgDMrvWLbE/vSSlPcGSXhoS8poTqlsq
         hXGGxo1rhg4/ktYN/EHJAGH6bgtd/04Ng4vwK1sI70JvnCzEIfXARu3rdJfFzYJduwEt
         z799Q2NUZigXVNTeTUV5A83Z85zS1erHBRZVbxLq5FbBk0+GSogFOsjtpdV5Sw6/yz25
         1viuV7tro8gQWLQqkM/lSWTcKqkpIStJN9RCh/fv2p9XlO+iCYvD1TFzmOfpdRJM65aj
         DwPDZx6EfgTpm41TWQJ/t6dG5GbUwUgOH1MmgJWxlGkeU5jBAsOPQ4nnkWtZQY5Nc8wh
         bsZQ==
X-Gm-Message-State: ANoB5pnUqLJhJwLUU46WZzjxKSiBzJ0PoD95ghLRXb/V7O3V68cBAOnv
        uYoxdG/r4NWNPVCkJmP0PhU=
X-Google-Smtp-Source: AA0mqf7mkN6VaKEXNOipzgBKrRs07XriztMXV512rHubp1p0SIIhGRx3Jlc3O4VZszf/5HOLKLHdIQ==
X-Received: by 2002:a05:6000:38e:b0:242:2390:15a with SMTP id u14-20020a056000038e00b002422390015amr16877183wrf.71.1670875731570;
        Mon, 12 Dec 2022 12:08:51 -0800 (PST)
Received: from suse.localnet (host-79-41-27-125.retail.telecomitalia.it. [79.41.27.125])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4fd1000000b0024246991121sm9527080wrw.116.2022.12.12.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:08:50 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Mon, 12 Dec 2022 21:08:49 +0100
Message-ID: <8194794.NyiUUSuA9g@suse>
In-Reply-To: <Y5Zc0qZ3+zsI74OZ@ZenIV>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
 <20221211213111.30085-3-fmdefrancesco@gmail.com> <Y5Zc0qZ3+zsI74OZ@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On domenica 11 dicembre 2022 23:42:26 CET Al Viro wrote:
> On Sun, Dec 11, 2022 at 10:31:10PM +0100, Fabio M. De Francesco wrote:
> >  out_put:
> >  	ufs_put_page(page);
> > 
> > -out:
> > -	return err;
> > 
> >  out_unlock:
> >  	unlock_page(page);
> >  	goto out_put;
> 
> Something strange has happened, all right - look at the situation
> after that patch.  You've got
> 
> out_put:
> 	ufs_put_page(page);
> out_unlock:
> 	unlock_page(page);
> 	goto out_put;
> 
> Which is obviously bogus.

I finally could go back to this small series and while working to fix the 
errors that yesterday you had found out I think I saw what happened...

Are you talking about ufs_add_link, right?

If so, you wrote what follows at point 14 of one of your emails:

-----

14) ufs_add_link() - similar adjustment to new calling conventions
for ufs_get_page().  Uses of page_addr: fed to ufs_put_page() (same as
in ufs_find_entry() kaddr is guaranteed to point into the same page and
thus can be used instead) and calculation of position in directory, same
as we'd seen in ufs_set_link().  The latter becomes page_offset(page) +
offset_in_page(de), killing page_addr off.  BTW, we get
                kaddr = ufs_get_page(dir, n, &page);
                err = PTR_ERR(kaddr);
                if (IS_ERR(kaddr))
                        goto out;
with out: being just 'return err;', which suggests
                kaddr = ufs_get_page(dir, n, &page);
                if (IS_ERR(kaddr))
                        return ERR_PTR(kaddr);
instead (and that was the only goto out; so the label can be removed).
The value stored in err in case !IS_ERR(kaddr) is (thankfully) never
used - would've been a bug otherwise.  So this is an equivalent 
transformation.

-----

Did you notice "so the label can be removed"?
I must have misinterpreted what you wrote there. Did I?

I removed the "out" label, according to what it seemed to me the correct way 
to interpret your words.

However at that moment I didn't see the endless loop at the end of the 
function. Then I "fixed" (sigh!) it in 3/3 by terminating that endless loop
with a "return 0". 

However that was another mistake because after "got_it:" label we have "err = 
ufs_commit_chunk(page, pos, rec_len);". 

To summarize: I can delete _only_ the label and leave the "return err;" in the 
block after the "out_put:" label. 

Am I looking at it correctly now?

Thanks,

Fabio


