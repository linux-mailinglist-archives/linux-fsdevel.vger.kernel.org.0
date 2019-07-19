Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3486D7D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 02:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfGSAg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 20:36:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38635 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfGSAg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:36:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so14708142plb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 17:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OnU2jQx1H+2VCBHEGo1995LVw57aSop7IIeZNBH89nc=;
        b=PIBTVtTqR6+ev2CTE/DKLURMWifMrFafD1Q/T4svlXBkiVuxjUkHCnMG1lfswD8T5o
         SgX5fQFN3SxryUwTHj74wUzFhGQ40vKyiFtztJTX7ZpRVQ8NC3wNSUUhYHSB5LpPv/kn
         zkCO5VB1D2Jbem/fs7JWp0gL+rpoTsp8TsJSEQvoOaBgrKd9oSJuvDg3q2bbbJpfNcT1
         1Jsr6KcydEMbUD0wO5fliFID/VjPvBFec+xMzAl1JpYwvngWXGClZ4pztq8Ot2oAO6p7
         g300dx6bwoNHVv6bq/1oq4pooVSrXDJzv/hvMSv0TAOOn31teG9WAuJs1KTQ9/UFaqg+
         MroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnU2jQx1H+2VCBHEGo1995LVw57aSop7IIeZNBH89nc=;
        b=L3FPicJsOorcUmJunILMDYi/FV1xWESsx9Xv8MAlR8NmB6pMPJVp2H8U6D/+evQU5C
         e0AcLuTGhvgawqQ28OVG4P4ElWEMLHDJvSwjcNEIAGvjHIXtckRRH3vsS09DJsIotiM2
         QJyq6BWeYMYgrt8g4g4yc4lpRa3zNF7J5N6BaUz9L1iE5rSebhFluRoHAjC32U3kNclD
         7z7sQ+lQwES0C2q4JDbMc9GVdq9yk2xOKBi6K6UOW8eoDaUYhzdfv9mYo+is7xqtxoY3
         MC73U1ZAnvfyssFszzSfO1YYTkUz//X208pCDiMUUpg0CYKZ1JFISBwwEF5xWCwuMxE2
         FnaA==
X-Gm-Message-State: APjAAAUCtm2Uh59WxKXDHc8sPE24NXgoLQXeeVW+Z+IIQRjVnMSCdrd9
        Z4fVYIJKtGzihv3ZbaEIsE3Q3hhAp/4=
X-Google-Smtp-Source: APXvYqxCMvNQL956cnE+p4k3mnSVCs+/HR7epvTt3H3ohlGcfLW7nf/6SFkkyRx2IsDwIHxlAocz9A==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr52272137plp.227.1563496617905;
        Thu, 18 Jul 2019 17:36:57 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r6sm53800797pjb.22.2019.07.18.17.36.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:36:57 -0700 (PDT)
Date:   Thu, 18 Jul 2019 17:36:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Support read/write with non-iter file-ops
Message-ID: <20190719003655.GO30636@minitux>
References: <20190718231054.8175-1-bjorn.andersson@linaro.org>
 <20190718231751.GV17978@ZenIV.linux.org.uk>
 <20190718234352.GN30636@minitux>
 <20190718235616.GM29731@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718235616.GM29731@kvack.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18 Jul 16:56 PDT 2019, Benjamin LaHaise wrote:

> On Thu, Jul 18, 2019 at 04:43:52PM -0700, Bjorn Andersson wrote:
> > On Thu 18 Jul 16:17 PDT 2019, Al Viro wrote:
> > 
> > > On Thu, Jul 18, 2019 at 04:10:54PM -0700, Bjorn Andersson wrote:
> > > > Implement a wrapper for aio_read()/write() to allow async IO on files
> > > > not implementing the iter version of read/write, such as sysfs. This
> > > > mimics how readv/writev uses non-iter ops in do_loop_readv_writev().
> > > 
> > > IDGI.  How would that IO manage to be async?  And what's the point
> > > using aio in such situations in the first place?
> > 
> > The point is that an application using aio to submit io operations on a
> > set of files, can use the same mechanism to read/write files that
> > happens to be implemented by driver only implementing read/write (not
> > read_iter/write_iter) in the registered file_operations struct, such as
> > kernfs.
> > 
> > In this particular case I have a sysfs file that is accessing hardware
> > and hence will block for a while and using this patch I can io_submit()
> > a write and handle the completion of this in my normal event loop.
> > 
> > 
> > Each individual io operation will be just as synchronous as the current
> > iter-based mechanism - for the drivers that implement that.
> 
> Just adding the fops is not enough.  I have patches floating around at
> Solace that add thread based fallbacks for files that don't have an aio
> read / write implementation, but I'm not working on that code any more.

My bad. Took another look and now I see the bigger picture of how this
is currently implemented and why just adding the fops would defeat the
purpose of the api.

Sorry for the noise.

> The thread based methods were quite useful in applications that had a need
> for using other kernel infrastructure in their main event loops.
> 

Yes indeed.

Regards,
Bjorn
