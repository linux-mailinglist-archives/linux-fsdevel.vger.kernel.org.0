Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D02FC12B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 21:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbhASUfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 15:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbhASUf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:35:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8BC061573;
        Tue, 19 Jan 2021 12:34:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v24so24346382lfr.7;
        Tue, 19 Jan 2021 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGyeQId7ghuiubDiteHOq99u7bCiW9P86xlgrtBuPx0=;
        b=ptoZk/WdXfRsTKZwQ/J1ogvUQcEJs0Bqc8KV5FSG1R53TtpZZGpl0xldd5lU4FK54g
         fqvDz2igNb0eBNZWQnIX1doIRYsK0IbvN+NlEVzXJMIg4b066h5FCltE9iEgMjY4sgIo
         7vBTUALabI7sCL9p1UYjK57H24yE8IyUpbOTUqtaOaZyNeqZJJMz8Cb7uF3YPjdyDRNG
         I0qfNoplfJx7ofCcoH2Fv5y1SdwXmL7RSo5xv/x44xe9mpvKOBRG/Be18qBdQIrSBtv5
         +8mvR+wDyBjDtWOJJLKQyn4Fpn/5O94lsK46H0ZdMrnutMhYbxUqlIjQMQehNOJz7Tba
         mWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGyeQId7ghuiubDiteHOq99u7bCiW9P86xlgrtBuPx0=;
        b=nUBq3/EQXlPrNr7OW4oNaEICWNfItAoCUEwa27WjHRXrKwolU3mq/ySQl2oYLOqePF
         hmrAgor/rIyTReRtbt8Qp6yqcNe5kPcxlfk7BDk9q303Dkj4cX4rrfxQbZS5UI/yIBjg
         H3lWS9jsefU84OkExMAj3M96KHCuh9UrG1xJrnexNJcN12Ll/DsaHPagjAx77q+PppB2
         VprEYG5pWroE5g8PUBGS+kWFInzjvZIVWkzIRVZHKuf/pSiwwYCUIG9BZowqaJd38fO4
         68VSAJHx0kGyQThH0exCPQoBOs4ECAcQptkKC3rPKdt8W5YoIqDCIHy4DoWG3ytQcxQL
         mCjQ==
X-Gm-Message-State: AOAM5333/4ptvbbx4PlxJJ8gVLYWdfIMJciqmX9q1MBMWTh6HLM91DZ+
        LTgEU85zPEpbWrft0fo2vHY=
X-Google-Smtp-Source: ABdhPJyZLECKkiiifagCkcTDcdstvBbQwLIeZMHqCpHWXAxvJ1OI4a3UyiJnO4JWjsb4gz0a1SR3aw==
X-Received: by 2002:a05:6512:338e:: with SMTP id h14mr2618345lfg.324.1611088485999;
        Tue, 19 Jan 2021 12:34:45 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id f18sm2375871lfh.137.2021.01.19.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:34:45 -0800 (PST)
Date:   Tue, 19 Jan 2021 22:34:42 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com
Subject: Re: [PATCH v17 01/10] fs/ntfs3: Add headers and misc files
Message-ID: <20210119203442.ricoppwmw662bjkd@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-2-almaz.alexandrovich@paragon-software.com>
 <20210103231755.bcmyalz3maq4ama2@kari-VirtualBox>
 <20210119104339.GA2674@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119104339.GA2674@kadam>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 01:43:39PM +0300, Dan Carpenter wrote:
> On Mon, Jan 04, 2021 at 01:17:55AM +0200, Kari Argillander wrote:
> > On Thu, Dec 31, 2020 at 06:23:52PM +0300, Konstantin Komarov wrote:
> > 
> > > +int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> > > +		   const u16 *upcase)
> > > +{
> > > +	int diff;
> > > +	size_t len = l1 < l2 ? l1 : l2;
> > 
> > I notice that these functions might call both ignore case and upcase in a row.
> > record.c - compare_attr()
> > index.c - cmp_fnames()
> > 
> > So maybe we can add bool bothcases.
> > 
> > int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> > 		   const u16 *upcase, bool bothcase)
> > {
> > 	int diff1 = 0;
> > 	int diff2;
> > 	size_t len = l1 < l2 ? l1 : l2;
> 
> size_t len = min(l1, l2);
> 
> I wonder if this could be a Coccinelle script?

Yeah I have to also confess that I just copy paste that. Didn't use
brain yet. Atleast to me it wasn't crystal clear right away what that
does. So Coccinelle script would definetly be good idea.

Someone has atleast made it https://github.com/bhumikagoyal/coccinelle_scripts
I wonder if we need to add cases also in "backwards". Haven't test these.
If patch is prefered from me then I can send it but someone else can
also send it.

@@
type T;
T x;
T y;
@@
(
- x < y ? x : y
+ min(x,y)
|
- x > y ? x : y
+ max(x,y)
|
- x < y ? y : x
+ max(x,y)
|
- x > y ? y : x
+ min(x,y)
) 

