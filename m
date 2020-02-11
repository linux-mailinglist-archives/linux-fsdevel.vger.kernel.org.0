Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC071599C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgBKTaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:30:02 -0500
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:8824 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728202AbgBKTaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:30:02 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 14:30:02 EST
Received: from pps.filterd (m0075553.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BJCt4e028576
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 14:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=proofpoint;
 bh=BTVR9J+4IqSiMHG7hlQzMagXk3pJAu3OnjvpmT3qFkk=;
 b=xBohbKZi92bPz52iGplIS45w20UFqrQRGugSg8jyo9ORtUryAOQ88WxVONUIhD4sBD0d
 Eliu1SoiIcoCf+YfARXcMFadXO89HhAmQW7pVMVmMZDbULgstAKst/oMy5hAkdItL2g9
 UeJeySPdGZ5FQvHU5JtcXxSCFhaZLfaK8WMUAdHPuBtHuENe0WZOoEm8R61f2EpGXvyG
 UOy3Rzv6zoNs3rS7gDFZH9NQiHZ20k4qPUq3KAY/TmjfvEoYCnDW/jCV37b/DpcZSkhx
 7e4RHSCEVQ372vYSZfYltSPdJAW00bR6YZgYQDHT/nWGW7gDS4wxmJwIuS8VaX9H28kc Xg== 
Authentication-Results: seagate.com;
        dkim=pass header.s=google header.d=seagate.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        by mx0a-00003501.pphosted.com with ESMTP id 2y2b9yma8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 14:23:18 -0500
Received: by mail-wm1-f72.google.com with SMTP id s25so1905886wmj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seagate.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BTVR9J+4IqSiMHG7hlQzMagXk3pJAu3OnjvpmT3qFkk=;
        b=Sl3awmkll4Smnnz8RfOlest6kZv9WfFyHy8mRU2E4NA77UrCRHY3C+NQ9MRThAox3n
         KNWx67mv1beZUKve2rrUEeQp+/UGz/LerukkUvWBh/s7SmIS89bQCgg4NcJuHb/RIi8I
         fe39Dr6GevSA1NhezRrXfHwj4TPGIESAko3yXpdhh1TWZg8OVMyPnn9NLyW13fq9unBp
         3JoUJ/8CN+s5xyNEu9RKhvrSsuGJFFM6hAn6jVB86TeUddLSBbMyx7qLgc4mRJVEb8mL
         6bHS5IWvL7K8tapLwElkY5vsTM9q7hqvq/J0ND19fW7uL2qe3J9KrZuyUMZqqfb48B8x
         JspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BTVR9J+4IqSiMHG7hlQzMagXk3pJAu3OnjvpmT3qFkk=;
        b=Wo+uaIcg1tGeyyiV4G88XX5WFJMjmUk8XZ95woXUbel7JeWoFqzxpf+uSpVGC602tF
         evAFUSkIto3BeoD5uhYDMdSdujpcnsu9ypA/kwNKhBKHQ2oGG1lW3w1okghR/mRZd0ZC
         e2Z7Rk/RQ+F2imefUDjfEz6TVYllyYdNiZjsPJAHxCrpZUuWqiWamtR7GV7101q7NOnK
         e/SXdHOO5p8tgYkrx8c/zqwdHqK1902Wzh3KtpCdsnFItxdWUKlD1xRYimz0aKOqTEFh
         HLml6Uu+ne1WVPfuDjGL8D2I9qAYddu59BI6AS/7n1Lh4Ea689Ei65zDyUDFXSNElw4P
         yz5Q==
X-Gm-Message-State: APjAAAVj8BDxGIJ/hJmYdYYhOfbySqkAadRtmhn392hzeXdy21oConjb
        oscRP7zeheLdY3EMRcupUEOu6ujZzAnEyrikYCFNq3ENUqhWhcRlGQZg3pCkHj1RdojODwpdkoX
        9+IZDiFBmWCb3ArzMmJMQMGLp5DPd+D1B2EoKLShwei4hcK2oaVGZyBULnkP9YiWyTJM=
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr9992308wrx.218.1581448995685;
        Tue, 11 Feb 2020 11:23:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5x4QzrbVO9N1OvG9wcjF0XiUc81EDKmcaSRNooakuGRheFmRV2pdMOnlVAZYJPtjgwjUa9mt/6HoIPNpmkcc=
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr9992282wrx.218.1581448995354;
 Tue, 11 Feb 2020 11:23:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
 <20200210215222.GB10776@dread.disaster.area>
In-Reply-To: <20200210215222.GB10776@dread.disaster.area>
From:   Tim Walker <tim.t.walker@seagate.com>
Date:   Tue, 11 Feb 2020 14:23:03 -0500
Message-ID: <CANo=J14NY9TG9RAUMfX2N-q2ZCqiD0CGGVWu-DTgKJDQK20CRg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
To:     Dave Chinner <david@fromorbit.com>
Cc:     Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_05:2020-02-11,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110129
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 4:52 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Feb 10, 2020 at 12:01:13PM -0600, Muhammad Ahmad wrote:
> > Background:
> > As the capacity of HDDs increases so is the need to increase
> > performance to efficiently utilize this increase in capacity. The
> > current school of thought is to use Multi-Actuators to increase
> > spinning disk performance. Seagate has already announced it=E2=80=99s S=
AS
> > Dual-Lun, Dual-Actuator device. [1]
> >
> > Discussion Proposal:
> > What impacts multi-actuator HDDs has on the linux storage stack?
> >
> > A discussion on the pros & cons of accessing the actuators through a
> > single combined LUN or multiple individual LUNs? In the single LUN
> > scenario, how should the device communicate it=E2=80=99s LBA to actuato=
r
> > mapping? In the case of multi-lun, how should we manage commands that
> > affect both actuators?
>
> What ground does this cover that wasn't discussed a couple of years
> ago at LSFMM?
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lwn.net_Articles_7=
53652_&d=3DDwIDaQ&c=3DIGDlg0lD0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJZ=
PWcIkPT0Uy3ynVsFU&m=3D2Eb6xxsYMqNOn4F3Yiola3ef2BTCKKg06zpnqJ_m1c8&s=3DJtxAw=
3Y13PHlYJygS847dBUVRXeM061Snm3hq01DFlY&e=3D
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

Hi all-

The multi-actuator fundamentals remain the same from a couple of years
ago. One development is to combine the actuators' address spaces into
a single LUN. We'd like to show you a couple of system block diagrams,
and talk about the queue management and command scheduling.

Best regards,
-Tim

--=20
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
