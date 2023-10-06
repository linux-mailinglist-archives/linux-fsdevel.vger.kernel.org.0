Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F67BB7D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjJFMjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjJFMji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:39:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4278CA;
        Fri,  6 Oct 2023 05:39:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40566f8a093so18637205e9.3;
        Fri, 06 Oct 2023 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696595976; x=1697200776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFk7IyFRrYSNGWj7a5/E3F905Z280GV53boWUoHFqYI=;
        b=hZ9lz5W7jBjNb90GT2L8am5AvS3v9/8QI2zA8/yVxS3Wm50tott8GZ6bcz0cjbFf+D
         nGjz92LQKAwNnMX4Pqb0PFr+WrkRFlyocMBr6lYlsZUrMxDkRwEDJ+sisTh3lrbk6fME
         d3qtlPFXcAqdgp3Komm6pn1jMXnPXesC5PG6QYAfpY+ZIBIP35xw4IIpmDFkcP+9M95A
         7KF86FhmobnhLjWlokqfAhrz8wVzwVCiYOcqzlkp0tYF8SmZWCAZ+SmKNcGEFNQu27s8
         4ZHqLUcLc6zVuTR/r3vPHbNRyNzTKpSGeus4TVSd3c1dTQmxF1AA/0AtseMOZMbaDKKB
         Ix5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595976; x=1697200776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFk7IyFRrYSNGWj7a5/E3F905Z280GV53boWUoHFqYI=;
        b=WthEhqYuLDoYMt2ftNX/YW8puSApA3sqacUWT1oL71EBEOsIEe5u8tofKm266W2B+c
         emj1C//BzYzTFXKqOjmJmLEDn24Kv1pDDpaYYCyK1K3U4sTggnq75ToXF+VBAvnfBNOQ
         6UZD8uAKzp7pUQM0NCsMfPHKLxRes3Z48l5F9JgnJET88SJdEUsZetoJ5e/SxTyyCsO0
         32DYRIGF0buUf/76uZRgm5qLDTKP4UPq+IpuTkNUrXLpj+hTvsgS8GjF7R9OJEVToEzy
         hWbY9QqkZjNtcdskPg22hbffVIThu/9VMfgaoPHB0yP3MKWQc19JJHe135nmNSp3OJb3
         01Ag==
X-Gm-Message-State: AOJu0YzYiHzyxrJS3MuyaKXFfZ0z6bxT3OayYeb6t0/U//Qewk81eobp
        Cz3DTEeBUJ4suiMeMis3JHKH756G/+c=
X-Google-Smtp-Source: AGHT+IHsi6G90Sj5OrAFrRmQTN3ae3/HEvCQWNmYQ5XOGIQEygt4dqAim3+4ZWUCcoQ2qPL5gf8uIw==
X-Received: by 2002:a7b:cb8b:0:b0:402:8c7e:3fc4 with SMTP id m11-20020a7bcb8b000000b004028c7e3fc4mr7342096wmi.30.1696595975878;
        Fri, 06 Oct 2023 05:39:35 -0700 (PDT)
Received: from f (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b004063d8b43e7sm5922644wmd.48.2023.10.06.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:39:35 -0700 (PDT)
Date:   Fri, 6 Oct 2023 14:39:21 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
Message-ID: <ZR//+QDRI3sBpqY4@f>
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
 <yt9dil7k151d.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yt9dil7k151d.fsf@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:19:58AM +0200, Sven Schnelle wrote:
> I'm seeing the same with the strace test-suite on s390. The problem is
> that /proc/*/fd now contains the file descriptors of the calling
> process, and not the target process.
> 

This is why:

+static inline struct file *files_lookup_fdget_rcu(struct files_struct *files, unsigned int fd)
+{
+       RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+                        "suspicious rcu_dereference_check() usage");
+       return lookup_fdget_rcu(fd);
+}

files argument is now thrown away, instead it always uses current.
