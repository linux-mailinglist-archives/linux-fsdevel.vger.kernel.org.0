Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1C6C778A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCXF6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXF6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:58:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4169C272C;
        Thu, 23 Mar 2023 22:58:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a16so630628pjs.4;
        Thu, 23 Mar 2023 22:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679637511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVvvlvt0PpLh4HRInUY1OVgFNwPoQgkN2SvfrIoJ8Gg=;
        b=fHF4pwLlhDq9y0o2piJ8HslYzWZWsc+oUxtmosySAoeNLilwB16RYiSYZEUGeoxRQ1
         Zk95FeX8eR8bqqTGPDbTeK06mLKFehY/nrkO8MurT9E38ETAZ16rUWZbW4JBHgsX1Lip
         WECF2mIwmBPEteVc/lf0oKp+m3v25Ohh9QeJ6FX0/Zbj+zv/fnGEbpvBvhRSKP8QWqgD
         K2Cwl+LgfS46FoS7g+mLaBjl+pDaFVwAvLFx2zpfZzFtvzKigfNHRAAnEYDP8i2xd0Ct
         VZl3GPQaZIE1IFjtlkcWXr9MHowHMnQxigZkQdswKsbDgGsDX6erZC4Nxnj9GrzA00wj
         /bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679637511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVvvlvt0PpLh4HRInUY1OVgFNwPoQgkN2SvfrIoJ8Gg=;
        b=m54ivl+UwKJQkiAvCpIn2H/JGiuL13WZRE4YaUkKmhKBNj6OKxKXtR+K3nn6ZaeUAX
         a1uFnF4x98XW9jIylvIBEfkUGMVTKnwwJFJd5VZ7tnIn+gcdfpamQg5fGippYppD6O8W
         WL/anX7Rqg8aUFeS3Xmmexl+1FVDYhP6RbUr7Kezl3cTxsT2GLL36vNSDUbpzCYsj7/x
         To9lB9WZ9m6gsQtm5urq2DbAnAh10jsPm6DNDmxxrjbPzK4z1NGSSkyY6Zut3etNK6Uj
         SrCWpJ1ZjlevbD1g0vpHDQynUemiUBoXMRD6k5It5UQEcWBKdQN+j+4frMiT/EMXugCw
         lHhQ==
X-Gm-Message-State: AAQBX9cgIinDKJOl/725iSQ91oaiFMB4uPqD3hfZiQ/H4qZoebzZ/Tmh
        FVVI/lti3/xYrnU+72wRFos=
X-Google-Smtp-Source: AKy350bgiSo4RK8v3fSxyjiNi5su3WXIPtt91Q1W+bEWqPozZ1bwZHir1WriQHcpv4Zdyf0QPIkQkw==
X-Received: by 2002:a17:90b:1215:b0:234:b170:1f27 with SMTP id gl21-20020a17090b121500b00234b1701f27mr1297339pjb.0.1679637510687;
        Thu, 23 Mar 2023 22:58:30 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a890a00b002339195a47bsm2180954pjn.53.2023.03.23.22.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:58:30 -0700 (PDT)
Date:   Fri, 24 Mar 2023 05:58:28 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>,
        aloktiagi@gmail.com
Subject: Re: [RFC v3 2/3] file: allow callers to free the old file descriptor
 after dup2
Message-ID: <ZB08BPmuqEsw3bqU@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
 <20230324051526.963702-2-aloktiagi@gmail.com>
 <ZB005rys4ZTeaQfU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB005rys4ZTeaQfU@casper.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:28:06AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 24, 2023 at 05:15:25AM +0000, aloktiagi wrote:
> > @@ -1119,8 +1119,12 @@ __releases(&files->file_lock)
> >  		__clear_close_on_exec(fd, fdt);
> >  	spin_unlock(&files->file_lock);
> >  
> > -	if (tofree)
> > -		filp_close(tofree, files);
> > +	if (fdfile) {
> > +		*fdfile = tofree;
> > +	} else {
> > +		if (tofree)
> > +			filp_close(tofree, files);
> > +	}
> 
> Why not:
> 
> 	if (fdfile)
> 		 *fdfile = tofree;
> 	else if (tofree)
> 		filp_close(tofree, files);
> 
> Shorter and makes the parallel structure more obvious.
> 

Agreed. Thank you for suggesting that. I'll fix this in v4.

