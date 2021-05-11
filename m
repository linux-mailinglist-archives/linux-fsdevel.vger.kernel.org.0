Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917B3379F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhEKFhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhEKFhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 01:37:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81A1C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 22:36:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v4so4997098qtp.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kwxlo1zvqH/EpRuSSvIpL9DHSDeDPtliHsTTKoZaEMY=;
        b=BeIwhLWqPYt5oaVqgbcMNfmKnhdQGTcRgBES1wX6ZIn1zVy3qH8GIvkhUvuH5nZNqH
         oi8XAm0wErYsrxUxQCAAT6jDmlkJhGiAKvkmzqTVkrMlqUv6HgejP86JSxGtbSTKC6ya
         acVSnZjp7Rzh1HSND+k3U2wYVZvUDKU8XAvo4beun801j9rUfs9ZKI8L3C4ZnTyliuwz
         qZfy1p0hF/cuAZeGkKfs3ucGIOhaE9mF05hotzLmVavyEYtfaevdUvVAECchKHGmNNs+
         0VpqGS9ZVZj9WdlNAoQDxGRASqq4I11Yrun7Rvn8MVAPuvIao6yUOsT90Lep6JnGt/OI
         P8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kwxlo1zvqH/EpRuSSvIpL9DHSDeDPtliHsTTKoZaEMY=;
        b=Qnx9tpwj+AcRHNWg167AMwrJoGGgjMhMZTCSA1A8dppDekFfHMZfwH7P5M0BoK3GIR
         SoIvSfokOYEs60CGb7dQMydmc7uzWGhBpcNIu4eiXYmCJh6ClK/j/MT1fXkops6sX2iN
         +lDL5N76dMPQLoassJ4gpjnm1IYiv2sNGDXfG/TxuVe0GuSHIpRBPC/7WTxD4dtWS1ZS
         Nv+K5ADzeFvd/or3oOpm6o2/BNzQOaXnrRg3APIg/u5Plx6u8p+JiA/WMJKtajW3k42A
         rrUvTVVXhzXz+KEzmFiHdrGNCOv6mj+EdUlns2Abm3JR5siQv6A163YlFw9SyP3qp7Hh
         OapQ==
X-Gm-Message-State: AOAM532zQN1/ZefwVZBQ72PkWWr8BhJ2lN9SaBCTqIDcpj7UYNO4sESR
        AeZe2GUKrdQi5wNfx/3upvNQdEtxmJfGcmdOWL/kkg==
X-Google-Smtp-Source: ABdhPJy4FklGPZa1yhD9A5mY947hdq1Mdf74s853ARUP2DnDbSqBxoa7aJMiKYrVKJEOE7gK8TarKnHc873MLk8jqWA=
X-Received: by 2002:aed:2167:: with SMTP id 94mr26322781qtc.378.1620711359716;
 Mon, 10 May 2021 22:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com>
 <20210426184201.4177978-11-krisman@collabora.com> <CAOQ4uxh_AQCj2XJgVzFp862xhr70FAS6n3QjeeQSd_bizw3Ssw@mail.gmail.com>
 <87lf9153yy.fsf@collabora.com>
In-Reply-To: <87lf9153yy.fsf@collabora.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 10 May 2021 22:35:48 -0700
Message-ID: <CACGdZYKVKvFycypunLcgJOZzT+_iR4VPotycMEXi=sg7kgckUQ@mail.gmail.com>
Subject: Re: [PATCH RFC 10/15] fanotify: Introduce code location record
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e87d6b05c20744f8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000e87d6b05c20744f8
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 29, 2021 at 11:40 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Mon, Apr 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> This patch introduces an optional info record that describes the
> >> source (as in the region of the source-code where an event was
> >> initiated).  This record is not produced for other type of existing
> >> notification, but it is optionally enabled for FAN_ERROR notifications.
> >>
> >
> > I find this functionality controversial, because think that the fs provided
> > s_last_error*, s_first_error* is more reliable and more powerful than this
> > functionality.
> >
> > Let's leave it for a future extending proposal, should fanotify event reporting
> > proposal pass muster, shall we?
> > Or do you think that without this optional extension fanotify event reporting
> > will not be valuable enough?
>
> I think it is valuable enough without this bit, at least on a first
> moment.  I understand it would be useful for ext4 to analyse information
> through this interface, but the main priority is to have a way to push
> out the information that an error occured, as you mentioned.

Ack, if it's deemed cleaner we could look at sysfs on notification,
but having the information in the same event provides some convenience
factor, and avoids racing in the event that we're looking at an error
after the first one.

>
> Also, this might be more powerful if we stick to the ring buffer instead
> of single stlot, as it would allow more data to be collected than just
> first/last.
> >
> > Thanks,
> > Amir.
>
> --
> Gabriel Krisman Bertazi

--000000000000e87d6b05c20744f8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmAYJKoZIhvcNAQcCoIIPiTCCD4UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzyMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
MEvaI7F4ZN2DM20wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAIKZMQsUIWBTlSa6tHLU5L8W
YVOXfTkEXU6aeq8JjYjcj1fQD+1K0EQhvwz6SB5I0NhqfMLyQBUZHJXChsLGygbCqXbmBF143+sK
xsY5En+KQ03HHHn8pmLHFMAgvO2f8cJyJD3cBi8nMNRia/ZMy2jayQPOiiK34RpcoyXr80KWUZQh
iqPea7dSkHy8G0Vjeo4vj+RQBse+NKpyEzJilDUVpd5x307jeFjYBp2fLWt0UAZ8P2nUeSPjC2fF
kGXeiYWeVPpQCSzowcRluUVFrKApZDZpm3Ly7a5pMVFQ23m2Waaup/DHnJkgxlRQRbcxDhqLKrJj
tATPzBYapBLXne4xggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAH+
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF6wURYNhSSv
9htzo7Rrdmo4ViGBjbM/bf7sAe3eAn17MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDUxMTA1MzYwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCRnyBwtRs+WV9/tGrIu4qWKuToTDg7
tHxVxPcxP39av8/uGUqI3dzEcGYMrvbfP8ewo4Ef+UvPhtw/iKTAUZ5a+i4TVYY3ng91T6hQrdFb
tu5qg3fsmlmVCrhRqxoK7uCAgczKX1xv0RuG0ktMUAm5NBx25mstNp1Ntj08b2fR+6LECrqkKd21
0bIoCGSEsCygGj6MXY70UY5uCu53ZFEsdE99I+RcFKsSql7hQZJmc/6ub/aoFX09A3jL3bdmjqaK
kbh4csNQqRznw9tvSrztG1jmanWWLqHA/kKzTI27IaRBpJoJDHou2sK6ScJz42i/Xn3ikFwp+Hlb
xHMk7V/m
--000000000000e87d6b05c20744f8--
